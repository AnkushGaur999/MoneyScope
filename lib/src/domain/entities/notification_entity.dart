// "id": "notif_001",
// "type": "expense_added",
// "title": "Expense Added",
// "message": "₹250 spent on Groceries",
// "icon": "receipt_long",
// "color": "#3B82F6",
// "isRead": false,
// "createdAt": "2025-12-15T18:21:21.536Z",
// "metadata": {
// "expenseId": "exp_123",
// "categoryId": "cat_groceries",
// "amount": 250
// }

import 'package:money_scope/src/core/storage/database/app_database.dart';

class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String message;
  final String icon;
  final int color;
  final bool isRead;
  final DateTime date;
  final MetaData? metaData;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.isRead,
    required this.date,
    this.metaData,
  });
}

class MetaData {
  final String? expenseId;
  final String? categoryId;
  final double? amount;

  const MetaData({this.expenseId, this.categoryId, this.amount});
}

extension NotificationMapper on NotificationsTableData {
  NotificationEntity toDomain() {
    return NotificationEntity(
      id: id,
      type: type,
      title: title,
      message: message,
      icon: icon,
      color: color,
      isRead: isRead,
      date: date,
      metaData: MetaData(
        amount: amount,
        expenseId: expenseId,
        categoryId: categoryId,
      ),
    );
  }
}
