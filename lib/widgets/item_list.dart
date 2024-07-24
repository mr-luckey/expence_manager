import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  double progress = 0.6;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      // Space between the text and the new row
      Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              //color: Colors.grey, // Grey background for the container
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.directions_bike,
                //  color: Colors.white
              ),
            ),
          ),
          SizedBox(
              width:
              10), // Space between the icon and any other content
          Text(
            "Bike",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      SizedBox(
          height:
          20), // Space between the bike text and the task bar
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                10), // Rounded edges for the task bar
            child: LinearProgressIndicator(
              value: progress, // Example progress value
              // backgroundColor: Colors.grey[300],
              // color: Colors.blue,
              minHeight: 6, // Increased height of the task bar
            ),
          ),
          SizedBox(
              height:
              10), // Space between the task bar and the text
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$300',
                  style: TextStyle(
                    fontSize: 16,
                    // color: Colors.black
                  ),
                ),
                Text(
                  '\$500',
                  style: TextStyle(
                    fontSize: 16,
                    //  color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
          height: 10), // Space between the text and the new row
      Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              // color: Colors.grey, // Grey background for the container
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.phone_iphone,
                //  color: Colors.white
              ),
            ),
          ),
          SizedBox(
              width:
              10), // Space between the icon and any other content
          Text(
            "I Phone",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      SizedBox(
          height:
          20), // Space between the bike text and the task bar
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                10), // Rounded edges for the task bar
            child: LinearProgressIndicator(
              value: progress, // Example progress value
              // backgroundColor: Colors.grey[300],
              // color: Colors.blue,
              minHeight: 6, // Increased height of the task bar
            ),
          ),
          SizedBox(
              height:
              10), // Space between the task bar and the text
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$300',
                  style: TextStyle(
                    fontSize: 16,
                    //  color: Colors.black
                  ),
                ),
                Text(
                  '\$500',
                  style: TextStyle(
                    fontSize: 16,
                    // color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]
    );
  }
}
