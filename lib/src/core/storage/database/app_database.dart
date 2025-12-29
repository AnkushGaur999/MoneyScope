import 'dart:io';
import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/dao/analytics_dao.dart';
import 'package:money_scope/src/core/storage/database/dao/categories_dao.dart';
import 'package:money_scope/src/core/storage/database/dao/expenses_dao.dart';
import 'package:money_scope/src/core/storage/database/dao/notification_dao.dart';
import 'package:money_scope/src/core/storage/database/dao/user_dao.dart';
import 'package:money_scope/src/core/storage/database/tables/categories_table.dart';
import 'package:money_scope/src/core/storage/database/tables/expenses_table.dart';
import 'package:drift/native.dart';
import 'package:money_scope/src/core/storage/database/tables/notifications_table.dart';
import 'package:money_scope/src/core/storage/database/tables/user_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [CategoriesTable, ExpensesTable, NotificationsTable, UsersTable],
  daos: [ExpensesDao, CategoriesDao, AnalyticsDao, NotificationDao, UserDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'moneyscope.db'));
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;
}
