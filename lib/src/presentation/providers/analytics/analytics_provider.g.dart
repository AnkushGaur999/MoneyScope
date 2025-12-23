// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AnalyticsRangeSelector)
const analyticsRangeSelectorProvider = AnalyticsRangeSelectorProvider._();

final class AnalyticsRangeSelectorProvider
    extends $NotifierProvider<AnalyticsRangeSelector, AnalyticsRange> {
  const AnalyticsRangeSelectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsRangeSelectorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsRangeSelectorHash();

  @$internal
  @override
  AnalyticsRangeSelector create() => AnalyticsRangeSelector();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsRange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsRange>(value),
    );
  }
}

String _$analyticsRangeSelectorHash() =>
    r'446687c767215ec4bed35cc8ce5b24831ba18a38';

abstract class _$AnalyticsRangeSelector extends $Notifier<AnalyticsRange> {
  AnalyticsRange build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AnalyticsRange, AnalyticsRange>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnalyticsRange, AnalyticsRange>,
              AnalyticsRange,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(analyticsRepository)
const analyticsRepositoryProvider = AnalyticsRepositoryProvider._();

final class AnalyticsRepositoryProvider
    extends
        $FunctionalProvider<
          AnalyticsRepository,
          AnalyticsRepository,
          AnalyticsRepository
        >
    with $Provider<AnalyticsRepository> {
  const AnalyticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnalyticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyticsRepository create(Ref ref) {
    return analyticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsRepository>(value),
    );
  }
}

String _$analyticsRepositoryHash() =>
    r'adf281f28d8349e84f971fbc487915a3b4882a8d';

@ProviderFor(Analytics)
const analyticsProvider = AnalyticsProvider._();

final class AnalyticsProvider
    extends $AsyncNotifierProvider<Analytics, AnalyticsState> {
  const AnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHash();

  @$internal
  @override
  Analytics create() => Analytics();
}

String _$analyticsHash() => r'09b2770cf502771783151ad38f8082d47dad910e';

abstract class _$Analytics extends $AsyncNotifier<AnalyticsState> {
  FutureOr<AnalyticsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AnalyticsState>, AnalyticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AnalyticsState>, AnalyticsState>,
              AsyncValue<AnalyticsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
