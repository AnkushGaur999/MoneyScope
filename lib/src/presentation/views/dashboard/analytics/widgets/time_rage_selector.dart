import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/presentation/providers/analytics/analytics_provider.dart';

class TimeRangeSelector extends StatelessWidget {
  const TimeRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, child) {
        final range = ref.watch(analyticsRangeSelectorProvider);

        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _RangeButton(
                'Week',
                range.name == "week",
                onTap: () => ref
                    .read(analyticsRangeSelectorProvider.notifier)
                    .updateRange(AnalyticsRange.week),
              ),
              _RangeButton(
                'Month',
                range.name == "month",
                onTap: () => ref
                    .read(analyticsRangeSelectorProvider.notifier)
                    .updateRange(AnalyticsRange.month),
              ),
              _RangeButton(
                'Year',
                range.name == "year",
                onTap: () => ref
                    .read(analyticsRangeSelectorProvider.notifier)
                    .updateRange(AnalyticsRange.year),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RangeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RangeButton(this.label, this.selected, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? colors.onPrimary : colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
