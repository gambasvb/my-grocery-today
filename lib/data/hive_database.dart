import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  // refference our box
  final _myBox = Hive.box("expenses_database");
  // write data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
          name: name, amount: amount, dateTime: dateTime);
      allExpenses.add(expense);
      // ExpenseItem expense = ExpenseItem(
      //     name: savedExpenses[i][0],
      //     amount: savedExpenses[i][1],
      //     dateTime: savedExpenses[i][2]);
      // allExpenses.add(expense);
    }
    return allExpenses;
  }

  // delete data
  // void deleteData() {
  //   try {
  //     _myBox.delete("ALL_EXPENSES");
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
