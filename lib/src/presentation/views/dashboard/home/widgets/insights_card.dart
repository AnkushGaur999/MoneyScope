import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';


class InsightsCard extends StatelessWidget {
  final CategorySpentEntity? topExpense;
  final double? totalSpent;

  const InsightsCard({super.key, this.topExpense, this.totalSpent});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    int? spentPercent;
    int? totalExpense;

    if (topExpense != null && totalSpent != null) {
      totalExpense = topExpense?.total.toInt();
      spentPercent = (topExpense!.total.toInt() * 100) ~/ totalSpent!.toInt();
    }

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1,
          children: [

            Text(
              "Insights",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Divider(),
            ListTile(
              leading: Icon(Icons.insights_rounded, color: Colors.blueAccent),
              title: RichText(
                text: TextSpan(
                  style: textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Top Category: ',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextSpan(
                      text: topExpense?.name ?? "----------",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                '₹${totalExpense ?? "-------"} • ${spentPercent ?? "-------"}% ',
                // ', // • Up 12% from last month',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
