import 'dart:convert';

class ReminderModel {
  String reminderDate;
  String description;
  String amount;
  String dueDate;

  ReminderModel({
    required this.reminderDate,
    required this.description,
    required this.amount,
    required this.dueDate,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      reminderDate: json['reminderDate'],
      description: json['description'],
      amount: json['amount'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reminderDate': reminderDate,
      'description': description,
      'amount': amount,
      'dueDate': dueDate,
    };
  }
}
