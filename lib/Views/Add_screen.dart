import 'package:expence_manager/widgets/Containers.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import '../constants/records.dart';
import '../widgets/record_widget.dart';
import '../widgets/topbar.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          topbar(
            title: "", // Add your title here
            leading: Container(), // Add your leading widget here
            trailing: Container(), // Add your trailing widget here
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containersav(),
                    containersav(),
                    containersav(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latest Entries",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45)),
                      child: Center(child: Icon(Icons.more_vert_rounded))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
