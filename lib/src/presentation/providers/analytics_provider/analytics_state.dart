import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';

class AnalyticsState {
  final String type;
  final double totalSpend;
  final List<CategorySpentEntity> categoryBreakdown;
  final List<DailySpentEntity> dailyTrend;

  AnalyticsState({
    required this.type,
    required this.totalSpend,
    required this.categoryBreakdown,
    required this.dailyTrend,
  });
}
