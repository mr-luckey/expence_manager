import 'package:expence_manager/Models/income_model.dart';
import 'package:hive/hive.dart'; // Import your IncomeModel class

class IncomeModelAdapter extends TypeAdapter<IncomeModel> {
  @override
  final int typeId = 2; // Unique identifier for this Hive type adapter

  @override
  IncomeModel read(BinaryReader reader) {
    try {
      final title = reader.read();
      final amount = reader.read();
      final categoryIndex = reader.read();
      final datetime = DateTime.parse(reader.read());
      final description = reader.read();

      return IncomeModel(
        title: title,
        amount: amount,
        category: categoryIndex,
        dateTime: datetime,
        description: description,
      );
    } catch (e) {
      // Log the error and rethrow
      print('Error reading IncomeModel: $e');
      rethrow;
    }
  }

  @override
  void write(BinaryWriter writer, IncomeModel obj) {
    writer.write(obj.title);
    writer.write(obj.amount);
    writer.write(obj.category);
    writer.write(obj.dateTime.toIso8601String());
    writer.write(obj.description);
  }
}
