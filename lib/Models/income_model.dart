import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class IncomeModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String amount;

  @HiveField(2)
  late int category;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late String description;

  @HiveField(5)
  late String type; // New field added

  IncomeModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.description,
    required this.type, // Update constructor
  });
}
