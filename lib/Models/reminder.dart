 import 'package:hive/hive.dart';
 // Generated file

@HiveType(typeId: 0)
class ReminderModel  {
  @HiveField(0)
  late String reminderDate;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String amount;

  @HiveField(3)
  late String dueDate;

  ReminderModel({
    required this.reminderDate,
    required this.description,
    required this.amount,
    required this.dueDate,
  });
}
