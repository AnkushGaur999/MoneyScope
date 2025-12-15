import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';

class NoAnalyticsDataView extends StatelessWidget {
  const NoAnalyticsDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bar_chart_outlined,
              size: 72,
              color: colors.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),

            Text(
              'No analytics data yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            Text(
              'Start adding expenses to see insights\nabout your spending habits.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: () {
                context.pushNamed(AppRoutes.addExpense);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
