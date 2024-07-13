// import 'package:expence_manager/Components/helpers/theme_provider.dart';
// import 'package:flutter/material.dart';
//
// class CardNavigation extends StatefulWidget {
//   CardNavigation({super.key, required this.totalIncome, required this.totalExpense});
//
//   final double totalIncome;
//   final double totalExpense;
//
//   @override
//   _CardNavigationState createState() => _CardNavigationState();
// }
//
// class _CardNavigationState extends State<CardNavigation> {
//   String selectedCategory = 'Income';
//
//   double getDisplayedAmount() {
//     switch (selectedCategory) {
//       case 'Income':
//         return widget.totalIncome;
//       case 'Expense':
//         return widget.totalExpense;
//       case 'Total':
//         return widget.totalIncome - widget.totalExpense;
//       default:
//         return 0.0;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = ThemeProvider().isDarkMode(context);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     selectedCategory = 'Income';
//                   });
//                 },
//                 child: Text('Income'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedCategory == 'Income' ? Colors.blue : Colors.grey,
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     selectedCategory = 'Expense';
//                   });
//                 },
//                 child: Text('Expense'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedCategory == 'Expense' ? Colors.blue : Colors.grey,
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     selectedCategory = 'Total';
//                   });
//                 },
//                 child: Text('Total'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedCategory == 'Total' ? Colors.blue : Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           AspectRatio(
//             aspectRatio: 8 / 3,
//             child: Card(
//               color: dark ? Colors.blue.shade900 : Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       selectedCategory,
//                       style: Theme.of(context).textTheme.headline6?.copyWith(
//                         color: dark ? Colors.white : Colors.blue.shade900,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       '\$ ${getDisplayedAmount().toStringAsFixed(2)}',
//                       style: Theme.of(context).textTheme.headline5?.copyWith(
//                         color: dark ? Colors.white : Colors.blue.shade900,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
