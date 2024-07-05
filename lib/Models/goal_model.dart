import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Goal  {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String contributionType;

  @HiveField(3)
  late DateTime deadline;

  Goal({
    required this.title,
    required this.amount,
    required this.contributionType,
    required this.deadline,
  });
}