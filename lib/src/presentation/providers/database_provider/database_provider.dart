import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/seed/category_seed.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase database(Ref ref) {
  final db = AppDatabase();

  // 🔥 Seed once when DB is first created
  CategorySeed.seed(db);

  ref.onDispose(() {
    db.close();
  });

  return db;
}
