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

@ProviderFor(Expense)
const expenseProvider = ExpenseProvider._();

final class ExpenseProvider
    extends $StreamNotifierProvider<Expense, List<ExpenseWithCategory>> {
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

String _$expenseHash() => r'063091667b922d89e60912f6331f8fed0520db32';

abstract class _$Expense extends $StreamNotifier<List<ExpenseWithCategory>> {
  Stream<List<ExpenseWithCategory>> build();
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
