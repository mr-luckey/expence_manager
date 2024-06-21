import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard1 extends StatefulWidget {
  const CustomCard1({super.key});

  @override
  State<CustomCard1> createState() => _CustomCard1State();
}

class _CustomCard1State extends State<CustomCard1> {
  double progress = 0.6;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'June 10, 2024',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Goal for this month',
                style: TextStyle(
                  fontSize: 14,
                  //  color: Colors.black54
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Rounded edges for the task bar
                    child: LinearProgressIndicator(
                      value: progress, // Example progress value
                      //backgroundColor: Colors.grey[300],
                      //  color: Colors.blue,
                      minHeight: 40, // Increased height of the task bar
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 12,
                    child: Text(
                      '\$300',
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 12,
                    child: Text(
                      '\$500',
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
