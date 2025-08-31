import 'package:depi/db/database.dart';
import 'package:depi/model/expense_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class HiveDatabase extends DatabaseModel {
  static const String boxName = 'Expense';
  static const String key = 'expense';
  static late final Box _box;

  @override
  Future<void> initDatabase() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  @override
  Future<List<ExpenseModel>> getAllExpense() async {
    final data = _box.get(key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((j) => ExpenseModel.fromMap(j)).toList();
  }

  @override
  Future<void> insertNewExpense(ExpenseModel journal) async {
    final journals = await getAllExpense();
    journal.id = DateTime.now().millisecondsSinceEpoch; // unique id
    journals.add(journal);
    final journalsMaps = journals.map((j) => j.toMap()).toList();
    final journalsJson = jsonEncode(journalsMaps);
    await _box.put(key, journalsJson);
  }

  @override
  Future<void> updateExpense(ExpenseModel journal) async {
    final journals = await getAllExpense();
    final index = journals.indexWhere((j) => j.id == journal.id);
    if (index != -1) {
      journals[index] = journal;
      final journalsMaps = journals.map((j) => j.toMap()).toList();
      final journalsJson = jsonEncode(journalsMaps);
      await _box.put(key, journalsJson);
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    final journals = await getAllExpense();
    journals.removeWhere((j) => j.id == id);
    final journalsMaps = journals.map((j) => j.toMap()).toList();
    final journalsJson = jsonEncode(journalsMaps);
    await _box.put(key, journalsJson);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
