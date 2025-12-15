import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/daily_spent_entity.dart';
import 'package:intl/intl.dart';

class ExpenseAnalyticsLineChart extends StatefulWidget {
  final List<DailySpentEntity> dailySpentItems;

  const ExpenseAnalyticsLineChart({super.key, required this.dailySpentItems});

  @override
  State<ExpenseAnalyticsLineChart> createState() =>
      _ExpenseAnalyticsLineChartState();
}

class _ExpenseAnalyticsLineChartState extends State<ExpenseAnalyticsLineChart> {
  bool showAvg = true;

  final List<Color> gradientColors = const [
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];

  @override
  Widget build(BuildContext context) {

    if (widget.dailySpentItems.isEmpty) {
      return const Center(child: Text('No data'));
    }

    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(_mainData()),
      ),
    );
  }

  /// ---------------------------
  /// Main Chart
  /// ---------------------------
  LineChartData _mainData() {
    final spots = _buildSpots();

    final maxY =
        widget.dailySpentItems
            .map((e) => e.total)
            .reduce((a, b) => a > b ? a : b) *
        1.2;

    return LineChartData(
      minX: 0,
      maxX: (spots.length - 1).toDouble(),
      minY: 0,
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        horizontalInterval: maxY / 4,
        getDrawingHorizontalLine: (_) => const FlLine(color: Colors.white10),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, _) =>
                Text('₹${value.toInt()}', style: const TextStyle(fontSize: 10)),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: _bottomTitle,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white24),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 4,
          gradient: LinearGradient(colors: gradientColors),
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((c) => c.withValues(alpha: 0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  /// ---------------------------
  /// Average Line
  /// ---------------------------
  // LineChartData _avgData() {
  //   final avg =
  //       widget.dailySpentItems.map((e) => e.total).reduce((a, b) => a + b) /
  //       widget.dailySpentItems.length;
  //
  //   final spots = List.generate(
  //     widget.dailySpentItems.length,
  //     (i) => FlSpot(i.toDouble(), avg),
  //   );
  //
  //   return LineChartData(
  //     minX: 0,
  //     maxX: (spots.length - 1).toDouble(),
  //     minY: 0,
  //     maxY: avg * 1.5,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: spots,
  //         isCurved: true,
  //         barWidth: 3,
  //         color: Colors.orange,
  //         dotData: const FlDotData(show: false),
  //       ),
  //     ],
  //   );
  // }

  /// ---------------------------
  /// Helpers
  /// ---------------------------
  List<FlSpot> _buildSpots() {
    return widget.dailySpentItems
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.total))
        .toList();
  }

  Widget _bottomTitle(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= widget.dailySpentItems.length) {
      return const SizedBox.shrink();
    }

    final date = widget.dailySpentItems[index].date;
    return SideTitleWidget(
      meta: meta,
      child: Text(
        DateFormat('dd').format(date),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
