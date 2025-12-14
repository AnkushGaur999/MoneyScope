import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  // Insert category
  Future<void> insertCategory(CategoriesTableCompanion category) =>
      into(categoriesTable).insert(category);

  // Watch all categories
  Stream<List<CategoriesTableData>> watchAllCategories() =>
      select(categoriesTable).watch();

  // Get category by id
  Future<CategoriesTableData?> getById(String id) {
    return (select(
      categoriesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
