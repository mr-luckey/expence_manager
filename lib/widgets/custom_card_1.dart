import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard1 extends StatelessWidget {
  final double totalGoalsAmount;
  final double currentSavings;
  //final double saveAmount;

  const CustomCard1({
    Key? key,
    required this.totalGoalsAmount,
    required this.currentSavings,
    //required this.saveAmount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    if (totalGoalsAmount != 0) {
      progress = currentSavings / totalGoalsAmount;
      if (progress > 1.0) progress = 1.0;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: Get.width * 0.9,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Savings Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 40,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '${(progress * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${currentSavings.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\$${totalGoalsAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
