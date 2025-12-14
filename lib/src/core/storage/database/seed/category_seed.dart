import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:uuid/uuid.dart';

class CategorySeed {
  static const _uuid = Uuid();

  static Future<void> seed(AppDatabase db) async {
    final existing = await db.select(db.categoriesTable).get();
    if (existing.isNotEmpty) return;

    final categories = [
      ('Food & Dining', 'restaurant', 0xFFEF4444),
      ('Groceries', 'shopping_cart', 0xFF22C55E),
      ('Transport', 'directions_car', 0xFF3B82F6),
      ('Fuel', 'local_gas_station', 0xFFF97316),
      ('Bills & Utilities', 'receipt_long', 0xFF6366F1),
      ('Shopping', 'shopping_bag', 0xFF10B981),
      ('Entertainment', 'movie', 0xFFA855F7),
      ('Subscriptions', 'subscriptions', 0xFFEC4899),
      ('Travel', 'flight', 0xFF0EA5E9),
      ('Fitness', 'fitness_center', 0xFF14B8A6),
      ('Health', 'local_hospital', 0xFFEF4444),
      ('Education', 'school', 0xFF6366F1),
      ('Personal Care', 'spa', 0xFF8B5CF6),
      ('Rent', 'home', 0xFF64748B),
      ('Insurance', 'security', 0xFF334155),
      ('EMI / Loans', 'account_balance', 0xFF475569),
      ('Savings', 'savings', 0xFF22C55E),
      ('Gifts & Donations', 'card_giftcard', 0xFFF59E0B),
      ('Miscellaneous', 'category', 0xFF94A3B8),
    ];

    for (final c in categories) {
      await db.categoriesDao.insertCategory(
        CategoriesTableCompanion.insert(
          id: _uuid.v4(),
          name: c.$1,
          icon: c.$2,
          color: c.$3,
        ),
      );
    }
  }
}
