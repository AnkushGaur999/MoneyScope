import 'package:flutter/material.dart';

class TotalSpentCard extends StatelessWidget {
  final double spentAmount;
  final double totalMonthlyBudget;

  const TotalSpentCard({
    super.key,
    required this.spentAmount,
    required this.totalMonthlyBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 8,
          children: [
            Text(
              "₹${spentAmount.toStringAsFixed(2)} Spent",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor:  (spentAmount / totalMonthlyBudget)> 1? 1 : spentAmount / totalMonthlyBudget,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purpleAccent],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Text(
              "Budget: ₹$totalMonthlyBudget - ${((spentAmount * 100) / totalMonthlyBudget).toStringAsFixed(2)}%",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
