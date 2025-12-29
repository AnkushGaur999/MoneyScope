import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/tables/user_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<bool> insertUser(UsersTableCompanion user) async {
    int rowId = await into(usersTable).insert(user);
    return rowId > 0;
  }

  Future<List<UsersTableData>> getUser() async {
    return await (select(usersTable)..limit(1)).get();
  }
}
