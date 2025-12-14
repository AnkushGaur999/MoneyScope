import 'package:money_scope/src/core/storage/database/dao/categories_dao.dart';
import 'package:money_scope/src/data/repositories/categories_repository.dart';
import 'package:money_scope/src/domain/entities/category_entity.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesDao dao;

  CategoryRepositoryImpl(this.dao);

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    return dao.watchAllCategories().map(
          (rows) => rows.map((e) => e.toDomain()).toList(),
    );
  }
}