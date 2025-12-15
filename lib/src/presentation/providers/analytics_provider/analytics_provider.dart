import 'package:money_scope/src/data/repositories/analytics_repository.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';
import 'package:money_scope/src/domain/repositories/analytics_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/analytics_provider/analytics_state.dart';
import 'package:money_scope/src/presentation/providers/database_provider/database_provider.dart';
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
        start = now.subtract(const Duration(days: 6)).copyWith(
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

    return _fetchData(start, now);
  }

  Future<void> getWeekData() async {
    ref.read(analyticsRangeSelectorProvider.notifier).updateRange(AnalyticsRange.week);
    state = const AsyncValue.loading();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    state = await AsyncValue.guard(() => _fetchData(start, now));
  }

  Future<void> getMonthData() async {
    ref.read(analyticsRangeSelectorProvider.notifier).updateRange(AnalyticsRange.month);
    state = const AsyncValue.loading();
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    state = await AsyncValue.guard(() => _fetchData(start, now));
  }

  Future<void> getYearData() async {
    ref.read(analyticsRangeSelectorProvider.notifier).updateRange(AnalyticsRange.year);
    state = const AsyncValue.loading();
    final now = DateTime.now();
    final start = DateTime(now.year, 1, 1);
    state = await AsyncValue.guard(() => _fetchData(start, now));
  }

  Future<AnalyticsState> _fetchData(DateTime start, [DateTime? end]) async {
    final repo = ref.read(analyticsRepositoryProvider);
    end ??= DateTime.now();

    final results = await Future.wait([
      repo.totalSpend(start, end),
      repo.categoryBreakdown(start, end),
      repo.dailyTrend(start, end),
    ]);

    final totalSpend = results[0] as double;
    final categoryBreakdown = results[1] as List<CategorySpentEntity>;
    final dailyTrend = results[2] as List<DailySpentEntity>;

    return AnalyticsState(
      totalSpend: totalSpend,
      categoryBreakdown: categoryBreakdown,
      dailyTrend: dailyTrend,
    );
  }
}
