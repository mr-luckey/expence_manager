import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget recordWidget(List<Map<String, dynamic>> records) {
  return ListView.builder(
    padding: EdgeInsets.all(0.0),
    itemCount: records.length,
    itemBuilder: (context, index) {
      final record = records[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        //color: Colors.black45
                        ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      record['iconData'],
                      // color: Colors.black45,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record['title'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black87
                      ),
                    ),
                    Text(
                      record['dateTime'],
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      record['symbols'],
                      style: const TextStyle(
                          //color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Text(
                      record['amount'].toString(),
                      style: const TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  record['paymentMethod'],
                  style: const TextStyle(
                      // color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 10),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
