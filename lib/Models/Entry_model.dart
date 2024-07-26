class EntryModel {
  final String title;
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final bool isIncome;

  EntryModel({
    required this.title,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  // Optional: You can also add methods to convert to/from JSON if needed
  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      title: json['title'],
      amount: json['amount'],
      description: json['description'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      isIncome: json['isIncome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
    };
  }
}
