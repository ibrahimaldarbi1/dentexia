// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(realtimeAppointments)
const realtimeAppointmentsProvider = RealtimeAppointmentsFamily._();

final class RealtimeAppointmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          Stream<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $StreamProvider<List<Map<String, dynamic>>> {
  const RealtimeAppointmentsProvider._({
    required RealtimeAppointmentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'realtimeAppointmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$realtimeAppointmentsHash();

  @override
  String toString() {
    return r'realtimeAppointmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String;
    return realtimeAppointments(ref, userId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RealtimeAppointmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$realtimeAppointmentsHash() =>
    r'53fef1160dce1d7dd39bd9093a96a58f57660f59';

final class RealtimeAppointmentsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Map<String, dynamic>>>, String> {
  const RealtimeAppointmentsFamily._()
    : super(
        retry: null,
        name: r'realtimeAppointmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RealtimeAppointmentsProvider call({required String userId}) =>
      RealtimeAppointmentsProvider._(argument: userId, from: this);

  @override
  String toString() => r'realtimeAppointmentsProvider';
}

@ProviderFor(realtimeNotifications)
const realtimeNotificationsProvider = RealtimeNotificationsProvider._();

final class RealtimeNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          Stream<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $StreamProvider<List<Map<String, dynamic>>> {
  const RealtimeNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'realtimeNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$realtimeNotificationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Map<String, dynamic>>> create(Ref ref) {
    return realtimeNotifications(ref);
  }
}

String _$realtimeNotificationsHash() =>
    r'a4dd5ddf83a24b4268e48a45a8bfccefd2e3e175';

@ProviderFor(unreadNotificationCount)
const unreadNotificationCountProvider = UnreadNotificationCountProvider._();

final class UnreadNotificationCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  const UnreadNotificationCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return unreadNotificationCount(ref);
  }
}

String _$unreadNotificationCountHash() =>
    r'afccea87de4e38544626472439b352c3e9f8403a';
