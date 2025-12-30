import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';

abstract class AnalyticsRepository {
  Future<double> totalSpend(DateTime start, DateTime end);

  Future<List<CategorySpentEntity>> categoryBreakdown(
    DateTime start,
    DateTime end,
  );

  Future<List<DailySpentEntity>> dailyTrend(DateTime start, DateTime end);
}
