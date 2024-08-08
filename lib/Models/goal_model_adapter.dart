import 'package:expence_manager/Models/goal_model.dart';
import 'package:hive/hive.dart';

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final typeId = 1; // Choose a unique ID for this adapter.

  @override
  Goal read(BinaryReader reader) {
    final title = reader.readString();
    final amount = reader.readDouble();
    final contributionType = reader.readString();
    final deadline = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final saveAmount = reader.readDouble();
    final lastContributionDate = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final dividedAmount = reader.readDouble(); // Read dividedAmount

    return Goal(
      title: title,
      amount: amount,
      contributionType: contributionType,
      deadline: deadline,
      saveAmount: saveAmount,
      lastContributionDate: lastContributionDate,
      dividedAmount: dividedAmount, // Set dividedAmount
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.contributionType);
    writer.writeInt(obj.deadline.millisecondsSinceEpoch);
    writer.writeDouble(obj.saveAmount);
    writer.writeInt(obj.lastContributionDate.millisecondsSinceEpoch);
    writer.writeDouble(obj.dividedAmount); // Write dividedAmount
  }
}
