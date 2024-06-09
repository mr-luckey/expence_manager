import 'package:expence_manager/widgets/Containers.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import '../constants/records.dart';
import '../widgets/record_widget.dart';
import '../widgets/topbar.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _selectedIndex = -1;

  void _onContainerTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _onContainerTap(index),
                      child: Container(
                        height: 70,  // Increased height
                        width: 70,   // Increased width
                        decoration: BoxDecoration(
                          color: _selectedIndex == index ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: _buildContainerContent(index),
                      ),
                    );
                  }),
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
                      border: Border.all(color: Colors.black45),
                    ),
                    child: Center(child: Icon(Icons.more_vert_rounded)),
                  ),
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

  Widget _buildContainerContent(int index) {
    if (index == 0) {
      return Icon(
        Icons.add,
        color: _selectedIndex == index ? Colors.white : Colors.black,
      );
    } else if (index == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet,
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
          Text(
            'Add Income',
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet,
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
          Text(
            'Add Expense',
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      );
    }
  }
}
