import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomExpenseCard extends StatelessWidget {
  final List<double> expenses = [300, 150, 100, 50];
  final List<String> labels = ['Rent', 'Groceries', 'Utilities', 'Misc'];
  final List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Reduced padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Monthly Expenses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Reduced font size
              ),
              SizedBox(height: 10), // Reduced spacing
              AspectRatio(
                aspectRatio: 1.0, // Adjusted aspect ratio to make the chart smaller
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 50, // Reduced center space radius
                    startDegreeOffset: 180,
                    sections: List.generate(expenses.length, (i) {
                      final isTouched = false;
                      final double fontSize = isTouched ? 20 : 14; // Reduced font size
                      final double radius = isTouched ? 50 : 40; // Reduced radius
                      final double value = expenses[i];
                      return PieChartSectionData(
                        color: colors[i],
                        value: value,
                        title: '${(value / expenses.reduce((a, b) => a + b) * 100).toStringAsFixed(1)}%',
                        radius: radius,
                        titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 10), // Reduced spacing
              Text(
                'This chart shows the distribution of different monthly expenses.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 12), // Reduced font size
              ),
            ],
          ),
        ),
      ),
    );
  }
}
