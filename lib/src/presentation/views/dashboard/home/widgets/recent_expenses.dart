import 'package:flutter/material.dart';
import 'package:money_scope/src/core/config/helper/time_formater.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';

class RecentExpenses extends StatelessWidget {
  final List<ExpenseWithCategory> recentExpenseList;

  const RecentExpenses({super.key, required this.recentExpenseList});

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
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            SizedBox(
              height: 260,
              child: recentExpenseList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _ExpenseTile(
                        recentExpenseList[index].category.name,
                        '₹${recentExpenseList[index].expense.amount}',
                        getDayLabel(recentExpenseList[index].expense.date),
                        Icon(
                          CategoryIconMapper.get(
                            recentExpenseList[index].category.icon,
                          ),
                          color: Color(recentExpenseList[index].category.color),
                          size: 30,
                        ),
                      ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: recentExpenseList.length,
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 60,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            "No Expenses Found!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
            ),
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
  final Icon icon;

  const _ExpenseTile(this.title, this.amount, this.date, this.icon);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: icon,
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
