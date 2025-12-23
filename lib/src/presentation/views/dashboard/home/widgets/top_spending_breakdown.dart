import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/widgets/expense_analytics_pie_chart.dart';

class TopSpendingBreakdown extends StatelessWidget {
  final double totalAmount;
  final List<CategorySpentEntity> expenseList;

  const TopSpendingBreakdown({
    super.key,
    required this.expenseList,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final total = expenseList.fold(0.0, (sum, item) => sum + item.total);

    final theme = Theme.of(context);

    return  Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Spending Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ExpenseAnalyticsPieChart(
                    spentCategories: expenseList,
                    totalAmount: total,
                    aspectRatio: 1.2,
                  ),
                ),


               if( expenseList.isNotEmpty
               ) Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        spacing: 10,
                        children: List.generate(
                          expenseList.length,
                          (i) => _LegendDot(
                            Color(expenseList[i].color),
                            expenseList[i].name,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot(this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
