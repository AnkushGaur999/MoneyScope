import 'package:money_scope/src/core/storage/database/dao/analytics_dao.dart';
import 'package:money_scope/src/domain/repositories/analytics_repository.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  final AnalyticsDao analyticsDao;

  AnalyticsRepositoryImpl({required this.analyticsDao});

  @override
  Future<List<CategorySpentEntity>> categoryBreakdown(
    DateTime start,
    DateTime end,
  ) async {
    return await analyticsDao.categoryBreakdown(start, end);
  }

  @override
  Future<List<DailySpentEntity>> dailyTrend(
    DateTime start,
    DateTime end,
  ) async {
    return await analyticsDao.dailyTrend(start, end);
  }

  @override
  Future<double> totalSpend(DateTime start, DateTime end) async {
    return await analyticsDao.totalSpend(start, end);
  }
}
