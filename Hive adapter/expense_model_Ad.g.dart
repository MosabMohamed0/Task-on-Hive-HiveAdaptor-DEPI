// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model_Ad.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelADAdapter extends TypeAdapter<ExpenseModelAD> {
  @override
  final int typeId = 0;

  @override
  ExpenseModelAD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModelAD(
      id: fields[0] as String?,
      date: fields[1] as DateTime,
      amount: fields[2] as double,
      category: fields[3] as String,
      note: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModelAD obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelADAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
