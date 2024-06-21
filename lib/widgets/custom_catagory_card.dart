import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomCategoryCard extends StatelessWidget {
  final List<double> expenses;
  final List<String> labels;
  final List<Color> colors;
  final List<Map<String, dynamic>> records;

  CustomCategoryCard({
    required this.expenses,
    required this.labels,
    required this.colors,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total sum of expenses
    double totalExpenses = expenses.reduce((a, b) => a + b);

    // Calculate the half of the total expenses
    double halfTotalExpenses = totalExpenses / 2;

    // Calculate the ratio of each expense to the half total
    List<double> sections =
        expenses.map((expense) => expense / halfTotalExpenses).toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        startDegreeOffset: 180,
                        sections: List.generate(expenses.length, (i) {
                          final double value = sections[i];
                          return PieChartSectionData(
                            color: colors[i],
                            value: value,
                            title: '${(value * 100).toStringAsFixed(1)}%',
                            radius: 40,
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffffffff),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(labels.length, (i) {
                        return Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: colors[i],
                                    width: 2), // Add border outline
                              ),
                              child: Icon(
                                Icons.circle,
                                //color: Colors.grey[600], // Change icon color to grey
                                size: 12,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              labels[i],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: records.map((record) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          // border: Border.all(color: Colors.grey), // Add border outline
                        ),
                        child: Icon(
                          record['iconData'],
                          // color: Colors.grey[600], // Change icon color to grey
                        ),
                      ),
                      title: Text(record['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(record['dateTime']),
                          SizedBox(height: 4),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            '${record['symbols']} ${record['amount']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ' ${record['paymentMethod']}',
                            style: TextStyle(
                              fontSize: 12,
                              //color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
