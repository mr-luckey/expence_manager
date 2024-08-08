import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Goal extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String contributionType;

  @HiveField(3)
  late DateTime deadline;

  @HiveField(4)
  late double saveAmount;

  @HiveField(5)
  late DateTime lastContributionDate;

  @HiveField(6)
  late double dividedAmount; // New field

  Goal({
    required this.title,
    required this.amount,
    required this.contributionType,
    required this.deadline,
    required this.saveAmount,
    required this.lastContributionDate,
    required this.dividedAmount, // Initialize new field
  });
}
