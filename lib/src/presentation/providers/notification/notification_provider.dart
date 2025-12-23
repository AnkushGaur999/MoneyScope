import 'package:money_scope/src/data/repositories/notification_repository.dart';
import 'package:money_scope/src/domain/entities/notification_entity.dart';
import 'package:money_scope/src/domain/repositories/notification_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  final database = ref.watch(databaseProvider);

  return NotificationRepositoryImpl(notificationDao: database.notificationDao);
}

@riverpod
class Notification extends _$Notification {
  late final NotificationRepository repository;

  @override
  Future<void> build() async {
    repository = ref.read(notificationRepositoryProvider);
  }

  Future<List<NotificationEntity>> fetchData(int pageKey) async {

    return await repository.allNotifications(page: pageKey);
  }

  Future<void> add(NotificationEntity notification) async {
    repository.addNotification(notification);
  }

  Future<void> delete(String id) async {
    repository.delete(id);
  }

  Future<void> updateNotification(String id, String title) async {
    repository.updateTitle(id, title);
  }
}
