import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          if (data.categoryBreakdown.isEmpty || data.dailyTrend.isEmpty) {
            return NoAnalyticsDataView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimeRangeSelector(),
                const SizedBox(height: 16),

                _TotalSpendCard(data.totalSpend),
                const SizedBox(height: 16),

                CategoryBreakdownCard(
                  data.categoryBreakdown,
                  totalAmount: data.totalSpend,
                ),

                const SizedBox(height: 16),

                SpendingTrendCard(dailySpentList: data.dailyTrend),
                const SizedBox(height: 16),

                _InsightsSection(),
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
}

class _TotalSpendCard extends StatelessWidget {
  final double totalAmount;

  const _TotalSpendCard(this.totalAmount);

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
              children: const [
                Icon(Icons.trending_down, color: Colors.green, size: 18),
                SizedBox(width: 4),
                Text(
                  '12% from last month',
                  style: TextStyle(color: Colors.green),
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
  const _InsightsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _InsightTile(
          icon: Icons.fastfood,
          text: 'Food spending ↑ 18%',
          color: Colors.red,
        ),
        _InsightTile(
          icon: Icons.calendar_today,
          text: 'Best day: Friday',
          color: Colors.blue,
        ),
        _InsightTile(
          icon: Icons.directions_car,
          text: 'Transport ↓ 9%',
          color: Colors.green,
        ),
      ],
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
      ),
    );
  }
}
