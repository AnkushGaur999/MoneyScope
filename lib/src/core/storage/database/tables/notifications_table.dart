import 'package:drift/drift.dart';

// "id": "notif_001",
// "type": "expense_added",
// "title": "Expense Added",
// "message": "₹250 spent on Groceries",
// "icon": "receipt_long",
// "color": "#3B82F6",
// "isRead": false,
// "expenseId": "exp_123",
// "categoryId": "cat_groceries",
// "amount": 250
// "date": "2025-12-15T18:21:21.536Z",


class NotificationsTable extends Table {
  TextColumn get id => text()();

  TextColumn get type => text()();

  TextColumn get title => text()();

  TextColumn get message => text()();

  TextColumn get icon => text()();

  IntColumn get color => integer()();

  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  DateTimeColumn get date => dateTime()();

  TextColumn get expenseId => text().nullable()();

  TextColumn get categoryId => text().nullable()();

  RealColumn get amount => real().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}