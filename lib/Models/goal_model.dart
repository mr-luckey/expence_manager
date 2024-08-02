import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class Goal extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  double saveAmount;

  @HiveField(3)
  DateTime deadline;

  @HiveField(4)
  String contributionType;

  @HiveField(5)
  DateTime lastContributionDate;

  Goal({
    required this.title,
    required this.amount,
    required this.saveAmount,
    required this.deadline,
    required this.contributionType,
    required this.lastContributionDate,
  });
}