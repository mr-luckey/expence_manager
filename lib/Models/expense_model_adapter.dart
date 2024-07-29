import 'package:expence_manager/Models/expense_model.dart';
import 'package:hive/hive.dart';

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 3;

  @override
  ExpenseModel read(BinaryReader reader) {
    return ExpenseModel(
      title: reader.read(),
      amount: reader.read(),
      category: reader.read(),
      dateTime: reader.read(),
      description: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer.write(obj.title);
    writer.write(obj.amount);
    writer.write(obj.category);
    writer.write(obj.dateTime);
    writer.write(obj.description);
  }
}