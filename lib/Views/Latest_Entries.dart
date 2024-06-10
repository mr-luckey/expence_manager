import 'package:expence_manager/constants/records.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import 'package:flutter/material.dart';

class LatestEntries extends StatefulWidget {
  const LatestEntries({super.key});

  @override
  State<LatestEntries> createState() => _LatestEntriesState();
}

class _LatestEntriesState extends State<LatestEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Entries',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Added space between app bar and body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latest Entries",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              height: 400,
              width: double.infinity,
              child: recordWidget(records),
            ),
          ),
        ],
      ),
    );
  }
}
