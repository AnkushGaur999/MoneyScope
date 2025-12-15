import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';

import 'expense_analytics_line_chart.dart';

class SpendingTrendCard extends StatelessWidget {
  final List<DailySpentEntity> dailySpentList;

  const SpendingTrendCard({super.key, required this.dailySpentList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Spending Trend',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Line chart placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpenseAnalyticsLineChart(dailySpentItems: dailySpentList),
            ),
          ],
        ),
      ),
    );
  }
}
