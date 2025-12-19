import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';
import 'package:money_scope/src/presentation/providers/analytics_provider/analytics_provider.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/widgets/category_breakdown_card.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/widgets/no_analytics_data_view.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/widgets/spend_trend_card.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/widgets/time_rage_selector.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsyncProvider = ref.watch(analyticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: analyticsAsyncProvider.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimeRangeSelector(),
                const SizedBox(height: 16),

                _mainContent(
                  data.type,
                  data.totalSpend,
                  data.categoryBreakdown,
                  data.dailyTrend,
                ),
              ],
            ),
          );
        },
        error: (error, stacktrace) =>
            SizedBox(child: Text("Something went wrong: $error")),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _mainContent(
    String type,
    double totalSpend,
    List<CategorySpentEntity> categoryBreakdown,
    List<DailySpentEntity> dailyTrend,
  ) {
    if (categoryBreakdown.isNotEmpty && dailyTrend.isNotEmpty) {
      return Column(
        children: [
          _TotalSpendCard(type: type, totalAmount: totalSpend),
          const SizedBox(height: 16),

          CategoryBreakdownCard(categoryBreakdown, totalAmount: totalSpend),

          const SizedBox(height: 16),

          SpendingTrendCard(dailySpentList: dailyTrend),
          const SizedBox(height: 16),

          _InsightsSection(categoryBreakdown, totalSpentAmount: totalSpend),
        ],
      );
    } else {
      return const NoAnalyticsDataView();
    }
  }
}

class _TotalSpendCard extends StatelessWidget {
  final String type;
  final double totalAmount;

  const _TotalSpendCard({required this.type, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Spent', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            Text(
              '₹$totalAmount',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.trending_down, color: Colors.green, size: 18),
                const SizedBox(width: 4),
                Text(
                  '12% from last $type',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsSection extends StatelessWidget {
  final List<CategorySpentEntity> topInsights;
  final double totalSpentAmount;

  const _InsightsSection(this.topInsights, {required this.totalSpentAmount});

  @override
  Widget build(BuildContext context) {
    final top3Insights = topInsights.length > 3
        ? topInsights.sublist(0, 3)
        : topInsights;

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        top3Insights.length,
        (index) => _InsightTile(
          icon: CategoryIconMapper.get(top3Insights[index].icon),
          text:
              "${top3Insights[index].name}: ${((top3Insights[index].total * 100) / totalSpentAmount).toStringAsFixed(2)}%",
          color: Color(top3Insights[index].color),
        ),
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InsightTile({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        trailing: Icon(Icons.insights_rounded, color: Colors.blueAccent),
      ),
    );
  }
}
