import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/dao/notification_dao.dart';
import 'package:money_scope/src/data/repositories/notification_repository.dart';
import 'package:money_scope/src/domain/entities/notification_entity.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationDao notificationDao;

  NotificationRepositoryImpl({required this.notificationDao});

  @override
  Future<bool> addNotification(NotificationEntity entity) {
    return notificationDao.insert(
      NotificationsTableCompanion.insert(
        id: entity.id,
        type: entity.type,
        title: entity.title,
        message: entity.message,
        icon: entity.icon,
        color: entity.color,
        date: entity.date,
        expenseId: Value(entity.metaData?.expenseId),
        categoryId: Value(entity.metaData?.categoryId),
        amount: Value(entity.metaData?.amount),
      ),
    );
  }

  @override
  Future<List<NotificationEntity>> allNotifications({required int page}) async {
    final result = await notificationDao.allNotifications(page: page);
    return result.map((e) => e.toDomain()).toList();
  }

  @override
  Future<bool> delete(String id) async {
    return await notificationDao.deleteNotification(id);
  }

  @override
  Future<bool> updateTitle(String id, String title) async {
    return await notificationDao.updateTitle(id, title);
  }

  @override
  Stream<List<NotificationEntity>> watchAllNotifications() {
    return notificationDao.watchAllNotifications().map(
      (rows) => rows.map((row) => row.toDomain()).toList(),
    );
  }
}
