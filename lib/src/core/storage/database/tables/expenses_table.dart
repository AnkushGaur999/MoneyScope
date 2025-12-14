import 'package:drift/drift.dart';

class ExpensesTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get categoryId => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isRecurring =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
