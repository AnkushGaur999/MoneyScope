import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';

class ExpenseAnalyticsPieChart extends StatefulWidget {
  final List<CategorySpentEntity> spentCategories;
  final double totalAmount;

  const ExpenseAnalyticsPieChart({
    super.key,
    required this.spentCategories,
    required this.totalAmount,
  });

  @override
  State<StatefulWidget> createState() => _ExpenseAnalyticsPietState();
}

class _ExpenseAnalyticsPietState extends State<ExpenseAnalyticsPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                duration: Duration(milliseconds: 800),
                curve: Curves.bounceOut,
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),

          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.spentCategories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

     final spentCategory =  widget.spentCategories[i];

     double percent = (spentCategory.total * 100)/ widget.totalAmount;

      return PieChartSectionData(
        color: Color(spentCategory.color),
        value: percent,
        title: '${percent.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
