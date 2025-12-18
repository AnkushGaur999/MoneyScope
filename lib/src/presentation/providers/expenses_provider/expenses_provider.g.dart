// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(expenseRepository)
const expenseRepositoryProvider = ExpenseRepositoryProvider._();

final class ExpenseRepositoryProvider
    extends
        $FunctionalProvider<
          ExpenseRepository,
          ExpenseRepository,
          ExpenseRepository
        >
    with $Provider<ExpenseRepository> {
  const ExpenseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExpenseRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExpenseRepository create(Ref ref) {
    return expenseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseRepository>(value),
    );
  }
}

String _$expenseRepositoryHash() => r'c8ee1c32766a63bf5166a9b8c3432aa2d0a354ba';

@ProviderFor(ExpenseSelectedMonth)
const expenseSelectedMonthProvider = ExpenseSelectedMonthProvider._();

final class ExpenseSelectedMonthProvider
    extends $NotifierProvider<ExpenseSelectedMonth, DateTime> {
  const ExpenseSelectedMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseSelectedMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseSelectedMonthHash();

  @$internal
  @override
  ExpenseSelectedMonth create() => ExpenseSelectedMonth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$expenseSelectedMonthHash() =>
    r'c1901e3415e8e08a9ebe54c910db5ce6c244ba27';

abstract class _$ExpenseSelectedMonth extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Expense)
const expenseProvider = ExpenseProvider._();

final class ExpenseProvider
    extends $AsyncNotifierProvider<Expense, List<ExpenseWithCategory>> {
  const ExpenseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseHash();

  @$internal
  @override
  Expense create() => Expense();
}

String _$expenseHash() => r'b705224b3d0ab71bebabdb0efbd35b36bd1c1171';

abstract class _$Expense extends $AsyncNotifier<List<ExpenseWithCategory>> {
  FutureOr<List<ExpenseWithCategory>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ExpenseWithCategory>>,
              List<ExpenseWithCategory>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ExpenseWithCategory>>,
                List<ExpenseWithCategory>
              >,
              AsyncValue<List<ExpenseWithCategory>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
