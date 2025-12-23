import 'package:money_scope/src/data/repositories/home_repository.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/domain/repositories/home_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/database/database_provider.dart';
import 'package:money_scope/src/presentation/providers/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return HomeRepositoryImpl(expensesDao: db.expensesDao);
}

@riverpod
class Home extends _$Home {
  @override
  FutureOr<HomeState> build() {
    DateTime now = DateTime.now();

    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(seconds: 1));

    return _fetchData(start, end);
  }

  Future<HomeState> _fetchData(DateTime start, [DateTime? end]) async {
    final repo = ref.read(homeRepositoryProvider);
    end ??= DateTime.now();

    final now = DateTime.now();

    final lStart = DateTime(now.year, now.month - 1);
    final lEnd = DateTime(
      now.year,
      now.month,
      1,
    ).subtract(Duration(seconds: 1));

    final results = await Future.wait([
      repo.totalSpend(lStart, lEnd),
      repo.totalSpend(start, end),
      repo.topSpending(start, end, 3),
      repo.getRecentExpense(start: start, end: end, limit: 3),
    ]);

    final lastMonthTotalSpent = results[0] as double;
    final currentMonthTotalSpent = results[1] as double;
    final expenseList = results[2] as List<CategorySpentEntity>;
    final recentExpense = results[3] as List<ExpenseWithCategory>;

    return HomeState(
      lastMonthTotalSpent: lastMonthTotalSpent,
      currentMonthTotalSpent: currentMonthTotalSpent,
      totalAmount: currentMonthTotalSpent,
      expenseList: expenseList,
      recentExpense: recentExpense,
    );

  }
}
