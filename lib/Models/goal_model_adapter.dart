import 'package:expence_manager/Models/goal_model.dart';
import 'package:hive/hive.dart';

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final typeId = 1; // Choose an unique ID for this adapter.

  @override
  Goal read(BinaryReader reader) {
    final title = reader.readString();
    final amount = reader.readDouble();
    final contributionType = reader.readString();
    final deadline = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return Goal(title: title, amount: amount, contributionType: contributionType, deadline: deadline);
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.contributionType);
    writer.writeInt(obj.deadline.millisecondsSinceEpoch);
  }
}
