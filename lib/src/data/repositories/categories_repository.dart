
import 'package:money_scope/src/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Stream<List<CategoryEntity>> watchCategories();
}