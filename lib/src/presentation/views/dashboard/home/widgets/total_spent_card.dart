import 'package:flutter/material.dart';

class TotalSpentCard extends StatelessWidget {
  const TotalSpentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 18,
          children: [
             Text(
              "₹24000.00 Spent",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.secondary,
              ),
            ),

             Text(
              "Budget: ₹30000 - 81%",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
