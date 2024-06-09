import 'package:expence_manager/widgets/Topbar.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, BuildContext? initialIndex});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: topbar(
              title: 'Savings',
              leading: Icon(Icons.arrow_back),
              trailing: Icon(Icons.menu),
            ),
          ),
          Text("Current Savaing"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: 150,
            // color: Colors.blueAccent,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
