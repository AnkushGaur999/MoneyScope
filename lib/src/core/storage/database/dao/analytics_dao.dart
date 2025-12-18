import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/tables/categories_table.dart';
import 'package:money_scope/src/core/storage/database/tables/expenses_table.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';
import '../app_database.dart';

part 'analytics_dao.g.dart';

@DriftAccessor(tables: [ExpensesTable, CategoriesTable])
class AnalyticsDao extends DatabaseAccessor<AppDatabase>
    with _$AnalyticsDaoMixin {
  AnalyticsDao(super.db);

  /// TOTAL SPEND BETWEEN DATES
  Future<double> totalSpend(DateTime start, DateTime end) async {
    final result = await customSelect(
      '''
      SELECT SUM(amount) AS total
      FROM expenses_table
      WHERE date BETWEEN ? AND ?
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).getSingle();

    return (result.data['total'] as num?)?.toDouble() ?? 0;
  }

  /// CATEGORY BREAKDOWN
  Future<List<CategorySpentEntity>> categoryBreakdown(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await customSelect(
      '''
      SELECT 
        c.id        AS categoryId,
        c.name      AS name,
        c.icon      AS icon,
        c.color     AS color,
        SUM(e.amount) AS total
      FROM expenses_table e
      JOIN categories_table c ON c.id = e.category_id
      WHERE e.date BETWEEN ? AND ?
      GROUP BY c.id
      ORDER BY total DESC
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).get();

    return rows.map((r) {
      return CategorySpentEntity(
        categoryId: r.data['categoryId'] as String,
        name: r.data['name'] as String,
        icon: r.data['icon'] as String,
        color: r.data['color'] as int,
        total: (r.data['total'] as num).toDouble(),
      );
    }).toList();
  }

  /// DAILY TREND
  Future<List<DailySpentEntity>> dailyTrend(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await customSelect(
      '''
        SELECT
        DATE(date, 'unixepoch', 'localtime') AS day,
        SUM(amount) AS total
        FROM expenses_table
        WHERE date BETWEEN ? AND ?
        GROUP BY day
        ORDER BY day
       ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).get();

    return rows
        .map((r) {
          final day = r.data['day'] as String?;
          if (day == null) {
            return null;
          }
          return DailySpentEntity(
            date: DateTime.parse(day),
            total: (r.data['total'] as num?)?.toDouble() ?? 0.0,
          );
        })
        .whereType<DailySpentEntity>()
        .toList();
  }
}
