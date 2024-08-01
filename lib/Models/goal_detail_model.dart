import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class DetailGoalModel {
  @HiveField(0)
  late DateTime startDate;

  @HiveField(1)
  late DateTime endDate;

  @HiveField(2)
  late double targetAmount;

  @HiveField(3)
  late double addedAmount;

  @HiveField(4)
  late String description;

  DetailGoalModel({
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.addedAmount,
    required this.description,
  });
}
