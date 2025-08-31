import 'package:depi/db/hive_adaptor/expense_model_Ad.dart';
import 'package:depi/db/hive_adaptor/hive_ad_db.dart';
import 'package:depi/task_7/expenseTrackerWithHiveAdaptor/add_edit_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List expenses = [];
  late final HiveAdapterDB hiveDatabaseDB;
  @override
  void initState() {
    super.initState();
    hiveDatabaseDB = HiveAdapterDB();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final data = await hiveDatabaseDB.getAllExpense();
    setState(() {
      expenses = data;
    });
  }

  void _addOrEditExpense({ExpenseModelAD? expense, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditScreen(expense: expense)),
    );

    if (result != null) {
      if (index == null) {
        await hiveDatabaseDB.insertNewExpense(result);
      } else {
        await hiveDatabaseDB.updateExpense(result);
      }
      _loadExpenses();
      setState(() {});
    }
  }

  void _deleteExpense(String id) async {
    await hiveDatabaseDB.deleteExpense(id);
    _loadExpenses();
    setState(() {});
  }

  void _clearAll() async {
    await hiveDatabaseDB.clear();
    _loadExpenses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker (Hive Adapter)"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearAll,
            tooltip: "Clear All",
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(child: Text("No expenses yet."))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text("\$${expense.amount.toStringAsFixed(1)}"),
                    ),
                    title: Text(expense.category),
                    subtitle: Text(
                      "${expense.note} - ${expense.date.toString().split(' ')[0]}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _addOrEditExpense(expense: expense, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteExpense(expense.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrEditExpense(),
      ),
    );
  }
}
