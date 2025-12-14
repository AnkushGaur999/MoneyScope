import 'package:flutter/material.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 1,
          children: [
            SizedBox(height: 4),

            Text(
              "Insights",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),
            ListTile(
              leading: Icon(
                Icons.insights,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              title: const Text('Top Category: Food'),
              subtitle: const Text('₹8,200 • 34% • Up 12% from last month'),
            ),
          ],
        ),
      ),
    );
  }
}
