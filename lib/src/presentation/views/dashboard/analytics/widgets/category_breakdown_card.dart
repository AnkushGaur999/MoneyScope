import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';

import 'expense_analytics_pie_chart.dart';

class CategoryBreakdownCard extends StatelessWidget {
  final List<CategorySpentEntity> spentCategories;
  final double totalAmount;

  const CategoryBreakdownCard(
    this.spentCategories, {
    super.key,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category Breakdown',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Donut placeholder
            ExpenseAnalyticsPieChart(
              spentCategories: spentCategories,
              totalAmount: totalAmount,
            ),

            const SizedBox(height: 16),

            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: spentCategories.map((item) {
                double percent = (item.total * 100) / totalAmount;

                return _LegendItem(item.name, percent, Color(item.color));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;

  const _LegendItem(this.label, this.percent, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(radius: 6, backgroundColor: color),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          Text('${percent.toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}

