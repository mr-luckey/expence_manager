import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class TotalModel {
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

  TotalModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.description,
  });
}
