import 'package:flutter/material.dart';

class RecentExpenses extends StatelessWidget {
  const RecentExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
              'Recent Expenses',
              style: textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const  Divider(),
            const _ExpenseTile('Groceries', '₹1,200', 'Today', Icons.shopping_cart),
            const  Divider(),
            const _ExpenseTile('Taxi', '₹300', 'Yesterday', Icons.local_taxi),
            const Divider(),
            const _ExpenseTile('Movie', '₹600', 'Sep 14', Icons.movie),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final IconData icon;

  const _ExpenseTile(this.title, this.amount, this.date, this.icon);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: colors.primary),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colors.onSurface,
        ),
      ),
    );
  }
}
