import 'package:money_scope/src/data/repositories/expenses_repository.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/domain/repositories/expenses_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/database_provider/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses_provider.g.dart';

@riverpod
ExpenseRepository expenseRepository(Ref ref) {
  final db = ref.watch(databaseProvider);

  return ExpenseRepositoryImpl(db.expensesDao);
}

@riverpod
class Expense extends _$Expense {
  @override
  Stream<List<ExpenseWithCategory>> build() {
    return ref.watch(expenseRepositoryProvider).watchAllExpensesWithCategory();
  }

  Future<void> addExpense(ExpenseEntity expense) async {
    await ref.read(expenseRepositoryProvider).addExpense(expense);
  }
}
