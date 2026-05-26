import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/presentation/providers/expenses/expenses_provider.dart';

void main() {
  group('ExpenseSelectedMonth Tests', () {
    test('initial state should be the first day of the current month', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final now = DateTime.now();
      final expectedDate = DateTime(now.year, now.month, 1);
      
      final selectedMonth = container.read(expenseSelectedMonthProvider);
      
      expect(selectedMonth, expectedDate);
    });

    test('update should change the state to the new date', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final newDate = DateTime(2023, 10, 1);
      
      container.read(expenseSelectedMonthProvider.notifier).update(newDate);
      
      final selectedMonth = container.read(expenseSelectedMonthProvider);
      expect(selectedMonth, newDate);
    });
  });
}
