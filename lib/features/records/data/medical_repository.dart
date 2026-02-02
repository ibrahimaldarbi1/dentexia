import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_provider.dart';
import '../domain/medical_record_entity.dart';

part 'medical_repository.g.dart';

class MedicalRepository {
  final SupabaseClient _supabase;
  final Box _cacheBox;

  MedicalRepository(this._supabase) : _cacheBox = Hive.box('medical_records_cache');

  Future<List<MedicalRecordEntity>> getPatientRecords(String patientId) async {
    // 1. Try to fetch fresh data from network
    try {
      final response = await _supabase
          .from('medical_records')
          .select()
          .eq('patient_id', patientId)
          .order('date', ascending: false);

      final records = (response as List).map((e) => MedicalRecordEntity.fromJson(e)).toList();

      // 2. Save to Local Cache (Overwriting old cache for this patient)
      await _cacheBox.put(patientId, jsonEncode(records));

      return records;
    } catch (e) {
      // 3. Network failed? Return Cached data
      if (_cacheBox.containsKey(patientId)) {
        final cachedString = _cacheBox.get(patientId);
        final List decoded = jsonDecode(cachedString);
        return decoded.map((e) => MedicalRecordEntity.fromJson(e)).toList();
      }
      rethrow; // No cache and no internet
    }
  }

  Future<void> saveRecord(MedicalRecordEntity record) async {
    // Optimistic: We assume online for write in this phase, 
    // but in a full sync engine, you'd push to a 'sync_queue' box here if fetch fails.
    await _supabase.from('medical_records').insert({
      'patient_id': record.patientId,
      'dentist_id': record.dentistId,
      'diagnosis': record.diagnosis,
      'treatment_notes': record.treatmentNotes,
      'date': record.date.toIso8601String(),
      'attachment_urls': record.attachmentUrls ?? [],
    });
  }
}

@Riverpod(keepAlive: true)
MedicalRepository medicalRepository(MedicalRepositoryRef ref) {
  return MedicalRepository(ref.watch(supabaseClientProvider));
}