import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class ExpenseModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String type; // New field added

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.description,
    required this.type, // Update constructor
  });
}
