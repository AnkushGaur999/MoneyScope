import 'package:money_scope/src/data/repositories/categories_repository.dart';
import 'package:money_scope/src/domain/entities/category_entity.dart';
import 'package:money_scope/src/domain/repositories/category_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/database_provider/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return CategoryRepositoryImpl(db.categoriesDao);
}

@riverpod
class Category extends _$Category {
  @override
  Stream<List<CategoryEntity>> build() {
    return ref.watch(categoryRepositoryProvider).watchCategories();
  }
}
