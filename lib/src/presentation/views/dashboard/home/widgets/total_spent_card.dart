import 'package:flutter/material.dart';

class TotalSpentCard extends StatelessWidget {
  final double spentAmount;
  final double totalAmount;

  const TotalSpentCard({
    super.key,
    required this.spentAmount,
    required this.totalAmount,
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
            // LinearProgressIndicator(
            //   value: spentAmount / totalAmount,
            //   minHeight: 10,
            //   borderRadius: BorderRadius.circular(12),
            //   backgroundColor: Theme.of(
            //     context,
            //   ).colorScheme.surfaceContainerHighest,
            //   valueColor: AlwaysStoppedAnimation(
            //     Theme.of(context).colorScheme.secondary,
            //   ),
            // ),

            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor:  (spentAmount / totalAmount)> 1? 1 : spentAmount / totalAmount,
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
              "Budget: ₹$totalAmount - ${((spentAmount * 100) / totalAmount).toStringAsFixed(2)}%",
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
