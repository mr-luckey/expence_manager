// import 'package:expence_manager/Models/custom_card_1_model.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:expence_manager/widgets/custom_card_1.dart';
//
// class ItemList extends StatefulWidget {
//   const ItemList({super.key});
//
//   @override
//   State<ItemList> createState() => _ItemListState();
// }
//
// class _ItemListState extends State<ItemList> {
//   late Box<CardModel> _cardBox;
//   List<CardModel> _cardModels = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _cardBox = Hive.box<CardModel>('cardModels');
//     _loadData();
//   }
//
//   void _loadData() {
//     setState(() {
//       _cardModels = _cardBox.values.toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Goals'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: _cardModels.isEmpty
//             ? Center(child: Text('No goals added yet.'))
//             : ListView.builder(
//           itemCount: _cardModels.length,
//           itemBuilder: (context, index) {
//             return CustomCard1(cardModel: _cardModels[index]);
//           },
//         ),
//       ),
//     );
//   }
// }
