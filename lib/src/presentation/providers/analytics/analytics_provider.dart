import 'package:money_scope/src/data/repositories/analytics_repository.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';
import 'package:money_scope/src/domain/repositories/analytics_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/analytics/analytics_state.dart';
import 'package:money_scope/src/presentation/providers/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_provider.g.dart';

enum AnalyticsRange { week, month, year }

@riverpod
class AnalyticsRangeSelector extends _$AnalyticsRangeSelector {
  @override
  AnalyticsRange build() {
    return AnalyticsRange.month;
  }

  void updateRange(AnalyticsRange range) {
    state = range;
  }
}

@riverpod
AnalyticsRepository analyticsRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return AnalyticsRepositoryImpl(analyticsDao: db.analyticsDao);
}

@riverpod
class Analytics extends _$Analytics {
  @override
  Future<AnalyticsState> build() async {
    final range = ref.watch(analyticsRangeSelectorProvider);
    final now = DateTime.now();

    late DateTime start;

    switch (range) {
      case AnalyticsRange.week:
        final now = DateTime.now();
        start = now
            .subtract(const Duration(days: 6))
            .copyWith(
              hour: 0,
              minute: 0,
              second: 0,
              millisecond: 0,
              microsecond: 0,
            );
        break;

      case AnalyticsRange.month:
        start = DateTime(now.year, now.month, 1);
        break;

      case AnalyticsRange.year:
        start = DateTime(now.year, 1, 1);
        break;
    }

    return _fetchData(type: range.name, start: start, end: now);
  }

  Future<AnalyticsState> _fetchData({
    required String type,
    required DateTime start,
    required DateTime end,
  }) async {
    final repo = ref.read(analyticsRepositoryProvider);

    final results = await Future.wait([
      repo.totalSpend(start, end),
      repo.categoryBreakdown(start, end),
      repo.dailyTrend(start, end),
    ]);

    final totalSpend = results[0] as double;
    final categoryBreakdown = results[1] as List<CategorySpentEntity>;
    final dailyTrend = results[2] as List<DailySpentEntity>;

    return AnalyticsState(
      type: type,
      totalSpend: totalSpend,
      categoryBreakdown: categoryBreakdown,
      dailyTrend: dailyTrend,
    );
  }
}
