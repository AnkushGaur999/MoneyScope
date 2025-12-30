
import 'package:drift/drift.dart';

class UsersTable extends Table {

  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get email => text()();
  TextColumn get country => text()();
  TextColumn get phone => text()();
  RealColumn get monthlyIncome => real()();
  TextColumn get employmentType => text()();
  TextColumn get profileImagePath => text().nullable()();


  @override
  Set<Column<Object>>? get primaryKey => {id};
}