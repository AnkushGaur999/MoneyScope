
import 'package:money_scope/src/domain/entities/user_entity.dart';

abstract class UserRepository {

  Future<bool> addUser({required UserEntity user});

  Future<UserEntity?> getUser();

}