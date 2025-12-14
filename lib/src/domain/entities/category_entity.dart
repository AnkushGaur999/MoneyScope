import 'package:money_scope/src/core/storage/database/app_database.dart';

class CategoryEntity {
  final String id;
  final String name;
  final String icon;
  final int color;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

extension CategoryMapper on CategoriesTableData {
  CategoryEntity toDomain() {
    return CategoryEntity(id: id, name: name, icon: icon, color: color);
  }
}
