import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/tables/notifications_table.dart';

part 'notification_dao.g.dart';

@DriftAccessor(tables: [NotificationsTable])
class NotificationDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationDaoMixin {


  NotificationDao(super.db);

  Future<bool> insert(NotificationsTableCompanion notification) async {
    final rowId = await into(notificationsTable).insert(notification);
    return rowId > 0;
  }

  Future<bool> deleteNotification(String id) async {
    final rows = await (delete(
      notificationsTable,
    )..where((table) => table.id.equals(id))).go();

    return rows > 0;
  }

  Stream<List<NotificationsTableData>> watchAllNotifications() {
    return (select(notificationsTable)..orderBy([
          (table) =>
              OrderingTerm(expression: table.date, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  Future<List<NotificationsTableData>> allNotifications({
    required int page,
  }) async {
    const limit = 10;

    final offset = page == 1 ? 0 : (page - 1) * limit;

    return (select(notificationsTable)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.date, mode: OrderingMode.desc),
          ])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<bool> updateTitle(String id, String title) async {
    final row =
        await (update(notificationsTable)
              ..where((table) => table.id.equals(id)))
            .write(NotificationsTableCompanion(title: Value(title)));

    return row > 0;
  }
}
