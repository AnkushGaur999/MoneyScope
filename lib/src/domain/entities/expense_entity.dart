import 'package:money_scope/src/core/storage/database/app_database.dart';

class ExpenseEntity {
  final String id;
  final String name;
  final double amount;
  final String categoryId;
  final String? note;
  final DateTime date;
  final bool isRecurring;

  const ExpenseEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.categoryId,
    this.note,
    required this.date,
    this.isRecurring = false,
  });
}

extension ExpenseMapper on ExpensesTableData {
  ExpenseEntity toDomain() {
    return ExpenseEntity(
      id: id,
      name: name,
      amount: amount,
      categoryId: categoryId,
      note: note,
      date: date,
      isRecurring: isRecurring,
    );
  }
}
