import 'package:hive_flutter/hive_flutter.dart';
part 'expense_model_Ad.g.dart';
@HiveType(typeId: 0)
class ExpenseModelAD extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String category;

  @HiveField(4)
  String note;

  ExpenseModelAD({
    this.id,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });
}
