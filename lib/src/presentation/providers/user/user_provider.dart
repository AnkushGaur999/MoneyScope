import 'package:money_scope/src/data/repositories/user_repository_impl.dart';
import 'package:money_scope/src/domain/entities/user_entity.dart';
import 'package:money_scope/src/domain/repositories/user_repository.dart';
import 'package:money_scope/src/presentation/providers/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final db = ref.watch(databaseProvider);

  return UserRepositoryImpl(userDao: db.userDao);
}

@riverpod
class User extends _$User {
  @override
  FutureOr<UserEntity?> build() {
    return ref.watch(userRepositoryProvider).getUser();
  }

  Future<void> addUser(UserEntity user) async {
    await ref.read(userRepositoryProvider).addUser(user: user);
  }
}
