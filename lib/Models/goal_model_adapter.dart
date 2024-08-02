import 'package:expence_manager/Models/goal_model.dart';
import 'package:hive/hive.dart';

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final typeId = 1; // Choose a unique ID for this adapter.

  @override
  Goal read(BinaryReader reader) {
    final title = reader.readString();
    final amount = reader.readDouble();
    final saveAmount = reader.readDouble();
    final deadline = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final contributionType = reader.readString();
    final lastContributionDate = DateTime.fromMillisecondsSinceEpoch(reader.readInt());

    return Goal(
      title: title,
      amount: amount,
      saveAmount: saveAmount,
      deadline: deadline,
      contributionType: contributionType,
      lastContributionDate: lastContributionDate,
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeDouble(obj.saveAmount);
    writer.writeInt(obj.deadline.millisecondsSinceEpoch);
    writer.writeString(obj.contributionType);
    writer.writeInt(obj.lastContributionDate.millisecondsSinceEpoch);
  }
}
