import 'package:hive/hive.dart';
 // Generated file by Hive

@HiveType(typeId: 4)
class CardModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String contributionType;

  @HiveField(2)
  final DateTime deadline;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final double targetAmount;

  CardModel({
    required this.title,
    required this.contributionType,
    required this.deadline,
    required this.amount,
    required this.targetAmount,
  });
}
