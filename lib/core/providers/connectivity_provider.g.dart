// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivityStatus)
const connectivityStatusProvider = ConnectivityStatusProvider._();

final class ConnectivityStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConnectivityStatus>,
          ConnectivityStatus,
          Stream<ConnectivityStatus>
        >
    with
        $FutureModifier<ConnectivityStatus>,
        $StreamProvider<ConnectivityStatus> {
  const ConnectivityStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityStatusHash();

  @$internal
  @override
  $StreamProviderElement<ConnectivityStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ConnectivityStatus> create(Ref ref) {
    return connectivityStatus(ref);
  }
}

String _$connectivityStatusHash() =>
    r'7c2b6a7963e935ef5273cd2aed11dcb4def68926';

@ProviderFor(OfflineDataNotifier)
const offlineDataProvider = OfflineDataNotifierProvider._();

final class OfflineDataNotifierProvider
    extends $NotifierProvider<OfflineDataNotifier, Map<String, dynamic>> {
  const OfflineDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineDataNotifierHash();

  @$internal
  @override
  OfflineDataNotifier create() => OfflineDataNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>>(value),
    );
  }
}

String _$offlineDataNotifierHash() =>
    r'70cb9d36ce65f3b8ffe88aca9e2cc98498a1920c';

abstract class _$OfflineDataNotifier extends $Notifier<Map<String, dynamic>> {
  Map<String, dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, dynamic>, Map<String, dynamic>>,
              Map<String, dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
