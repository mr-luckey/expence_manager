import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingPage extends StatefulWidget {
  const SavingPage({super.key});

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  double _progress = 0.6; // Example progress value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Saving',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // Space between app bar and text
            Center(
              child: Text(
                "Current Savings",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 50), // Space between text and circular container
            Center(
              child: CustomContainer(),
            ),
            SizedBox(height: 20), // Space between circular container and card
            Center(
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Goal for this month',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Rounded edges for the task bar
                            child: LinearProgressIndicator(
                              value: _progress, // Example progress value
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                              minHeight: 40, // Increased height of the task bar
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 12,
                            child: Text(
                              '\$300',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 12,
                            child: Text(
                              '\$500',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between card and new text
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Goal",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Center(
                          child: Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Space between the text and the new row
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Grey background for the container
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Icons.directions_bike, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10), // Space between the icon and any other content
                      Text(
                        "Bike",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Space between the bike text and the task bar
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Rounded edges for the task bar
                        child: LinearProgressIndicator(
                          value: _progress, // Example progress value
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                          minHeight: 6, // Increased height of the task bar
                        ),
                      ),
                      SizedBox(height: 10), // Space between the task bar and the text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$300',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            '\$500',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Space between the text and the new row
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Grey background for the container
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Icons.phone_iphone, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10), // Space between the icon and any other content
                      Text(
                        "I Phone",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Space between the bike text and the task bar
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Rounded edges for the task bar
                        child: LinearProgressIndicator(
                          value: _progress, // Example progress value
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                          minHeight: 6, // Increased height of the task bar
                        ),
                      ),
                      SizedBox(height: 10), // Space between the task bar and the text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$300',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            '\$500',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
