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
  final DateTime date;

  @HiveField(4)
  final String description;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
