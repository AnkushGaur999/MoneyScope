import 'package:intl/intl.dart';

String getDayLabel(DateTime date) {
  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final target = DateTime(date.year, date.month, date.day);

  if (target == today) {
    return 'Today';
  } else if (target == yesterday) {
    return 'Yesterday';
  } else {
    return DateFormat('dd MMM yyyy').format(date);
  }
}

List<DateTime> getPreviousMonths() {
  final now = DateTime.now();

  return List.generate(50, (index) {
    return DateTime(now.year, now.month - index, 1);
  });
}
