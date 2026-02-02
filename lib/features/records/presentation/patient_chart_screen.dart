import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../domain/medical_record_entity.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../admin/data/admin_repository.dart'; // To get patient list or pass patient object
import '../data/medical_repository.dart';

// Controller to fetch records
final patientRecordsProvider = FutureProvider.family<List<MedicalRecordEntity>, String>((ref, patientId) {
  return ref.read(medicalRepositoryProvider).getPatientRecords(patientId);
});

class PatientChartScreen extends ConsumerWidget {
  final String patientId;
  final String patientName;

  const PatientChartScreen({super.key, required this.patientId, required this.patientName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(patientRecordsProvider(patientId));

    return Scaffold(
      appBar: AppBar(
        title: Text("$patientName's Chart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => _showAddRecordDialog(context, ref),
          )
        ],
      ),
      body: recordsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
        data: (records) {
          if (records.isEmpty) return const Center(child: Text("No medical history found."));
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('MMM d, yyyy').format(record.date), 
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Icon(Icons.medical_services, size: 16, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text("Diagnosis: ${record.diagnosis}", 
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent)),
                      const SizedBox(height: 4),
                      Text(record.treatmentNotes),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddRecordDialog(BuildContext context, WidgetRef ref) {
    final diagnosisCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("New Treatment Record"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: diagnosisCtrl, decoration: const InputDecoration(labelText: "Diagnosis")),
            const SizedBox(height: 10),
            TextField(
              controller: notesCtrl, 
              maxLines: 3, 
              decoration: const InputDecoration(labelText: "Treatment Notes", border: OutlineInputBorder())
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final currentUser = ref.read(authControllerProvider).valueOrNull!;
              
              final newRecord = MedicalRecordEntity(
                id: '', // Supabase will generate
                patientId: patientId,
                dentistId: currentUser.id,
                diagnosis: diagnosisCtrl.text,
                treatmentNotes: notesCtrl.text,
                date: DateTime.now(),
              );

              await ref.read(medicalRepositoryProvider).saveRecord(newRecord);
              
              // Refresh the list
              ref.invalidate(patientRecordsProvider(patientId));
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text("Save Record"),
          )
        ],
      ),
    );
  }
}