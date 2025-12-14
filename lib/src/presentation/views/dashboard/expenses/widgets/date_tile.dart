import 'package:flutter/material.dart';

class DateTile extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateTile({super.key, required this.onDateSelected});

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.onDateSelected(_selectedDate);
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      tileColor: colors.surfaceContainerHighest.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(Icons.calendar_today, color: colors.primary),
      title: Text(
        _isToday(_selectedDate) ? 'Today' : _formatDate(_selectedDate),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _pickDate(context),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
