import 'package:money_scope/src/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<bool> addNotification(NotificationEntity entity);

  Future<bool> delete(String id);

  Stream<List<NotificationEntity>> watchAllNotifications();

  Future<List<NotificationEntity>> allNotifications({required int page,});

  Future<bool> updateTitle(String id, String title);
}
