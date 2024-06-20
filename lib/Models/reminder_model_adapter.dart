import 'package:expence_manager/Models/reminder.dart';
import 'package:hive/hive.dart'; // Import your ReminderModel class

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 0; // Unique identifier for this Hive type adapter

  @override
  ReminderModel read(BinaryReader reader) {
    return ReminderModel(
      reminderDate: reader.readString(),
      description: reader.readString(),
      amount: reader.readString(),
      dueDate: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer.writeString(obj.reminderDate);
    writer.writeString(obj.description);
    writer.writeString(obj.amount);
    writer.writeString(obj.dueDate);
  }
}
