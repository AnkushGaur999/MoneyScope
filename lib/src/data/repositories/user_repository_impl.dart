import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/dao/user_dao.dart';
import 'package:money_scope/src/domain/entities/user_entity.dart';
import 'package:money_scope/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDao userDao;

  UserRepositoryImpl({required this.userDao});

  @override
  Future<bool> addUser({required UserEntity user}) async {
    return await userDao.insertUser(
      UsersTableCompanion.insert(
        id: user.id,
        fullName: user.name,
        email: user.email,
        country: user.country,
        phone: user.phone,
        monthlyIncome: user.monthlyIncome,
        employmentType: user.empType,
        profileImagePath: Value(user.profileImagePath),
      ),
    );
  }

  @override
  Future<UserEntity?> getUser() async {
    final users = await userDao.getUser();

    if (users.isNotEmpty) {
      final value = users.first;

      UserEntity(
        id: value.id,
        name: value.fullName,
        email: value.email,
        phone: value.phone,
        country: value.country,
        monthlyIncome: value.monthlyIncome,
        empType: value.employmentType,
      );
    }
    return null;
  }
}
