// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dentist_schedule_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dentistScheduleControllerHash() =>
    r'a5a3d7cc26ec7fbde61ed163d439c73028d9070e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DentistScheduleController
    extends BuildlessAutoDisposeAsyncNotifier<List<AppointmentEntity>> {
  late final DateTime date;

  FutureOr<List<AppointmentEntity>> build(DateTime date);
}

/// See also [DentistScheduleController].
@ProviderFor(DentistScheduleController)
const dentistScheduleControllerProvider = DentistScheduleControllerFamily();

/// See also [DentistScheduleController].
class DentistScheduleControllerFamily
    extends Family<AsyncValue<List<AppointmentEntity>>> {
  /// See also [DentistScheduleController].
  const DentistScheduleControllerFamily();

  /// See also [DentistScheduleController].
  DentistScheduleControllerProvider call(DateTime date) {
    return DentistScheduleControllerProvider(date);
  }

  @override
  DentistScheduleControllerProvider getProviderOverride(
    covariant DentistScheduleControllerProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dentistScheduleControllerProvider';
}

/// See also [DentistScheduleController].
class DentistScheduleControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          DentistScheduleController,
          List<AppointmentEntity>
        > {
  /// See also [DentistScheduleController].
  DentistScheduleControllerProvider(DateTime date)
    : this._internal(
        () => DentistScheduleController()..date = date,
        from: dentistScheduleControllerProvider,
        name: r'dentistScheduleControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dentistScheduleControllerHash,
        dependencies: DentistScheduleControllerFamily._dependencies,
        allTransitiveDependencies:
            DentistScheduleControllerFamily._allTransitiveDependencies,
        date: date,
      );

  DentistScheduleControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  FutureOr<List<AppointmentEntity>> runNotifierBuild(
    covariant DentistScheduleController notifier,
  ) {
    return notifier.build(date);
  }

  @override
  Override overrideWith(DentistScheduleController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DentistScheduleControllerProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    DentistScheduleController,
    List<AppointmentEntity>
  >
  createElement() {
    return _DentistScheduleControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DentistScheduleControllerProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DentistScheduleControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AppointmentEntity>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _DentistScheduleControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          DentistScheduleController,
          List<AppointmentEntity>
        >
    with DentistScheduleControllerRef {
  _DentistScheduleControllerProviderElement(super.provider);

  @override
  DateTime get date => (origin as DentistScheduleControllerProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
