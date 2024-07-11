import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class IncomeModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String amount;

  @HiveField(2)
  late int categoryIndex;

  @HiveField(3)
  late DateTime datetime;

  @HiveField(4)
  late String description;

  IncomeModel({
    required this.title,
    required this.amount,
    required this.categoryIndex,
    required this.datetime,
    required this.description,
  });
}
