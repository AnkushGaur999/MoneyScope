import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/presentation/providers/analytics/analytics_provider.dart';

void main() {
  group('AnalyticsRangeSelector Tests', () {
    test('initial state should be AnalyticsRange.month', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final range = container.read(analyticsRangeSelectorProvider);
      expect(range, AnalyticsRange.month);
    });

    test('updateRange should change the state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(analyticsRangeSelectorProvider.notifier).updateRange(AnalyticsRange.week);
      expect(container.read(analyticsRangeSelectorProvider), AnalyticsRange.week);

      container.read(analyticsRangeSelectorProvider.notifier).updateRange(AnalyticsRange.year);
      expect(container.read(analyticsRangeSelectorProvider), AnalyticsRange.year);
    });
  });
}
