import 'package:depi/db/hive_adaptor/expense_model_Ad.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveAdapterDB {
  static Box<ExpenseModelAD>? _box;

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseModelADAdapter());
    _box = await Hive.openBox<ExpenseModelAD>('ExpenseAdapter');
  }

  Future<void> insertNewExpense(ExpenseModelAD expense) async {
    expense.id = DateTime.now().millisecondsSinceEpoch.toString();
    await _box?.put(expense.id, expense);
  }

  Future<List<ExpenseModelAD>> getAllExpense() async {
    final expense = _box?.values.toList() ?? [];
    expense.sort((a, b) => a.date.compareTo(b.date));
    return expense;
  }

  Future<void> updateExpense(ExpenseModelAD expense) async {
    if (_box!.containsKey(expense.id)) {
      await _box?.put(expense.id, expense);
    }
  }

  Future<void> deleteExpense(String id) async {
    await _box?.delete(id);
  }

  Future<void> clear() async {
    await _box?.clear();
  }
}
