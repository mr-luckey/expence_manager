import 'package:expence_manager/Models/custom_card_1_model.dart';
import 'package:hive/hive.dart';

class CardModelAdapter extends TypeAdapter<CardModel> {
  @override
  final typeId = 4; // Unique ID for this adapter

  @override
  CardModel read(BinaryReader reader) {
    final title = reader.readString();
    final contributionType = reader.readString();
    final deadline = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final amount = reader.readDouble();
    final targetAmount = reader.readDouble();

    return CardModel(
      title: title,
      contributionType: contributionType,
      deadline: deadline,
      amount: amount,
      targetAmount: targetAmount,
    );
  }

  @override
  void write(BinaryWriter writer, CardModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.contributionType);
    writer.writeInt(obj.deadline.millisecondsSinceEpoch);
    writer.writeDouble(obj.amount);
    writer.writeDouble(obj.targetAmount);
  }
}
