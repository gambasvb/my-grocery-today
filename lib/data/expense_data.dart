import 'package:flutter/material.dart';
import 'package:myapp/datetime/date_time_helper.dart';
import 'package:myapp/models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  // list of all expenses
  List<ExpenseItem> overAllExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overAllExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpenseList.add(newExpense);
    notifyListeners();
  }

  // delete expnses
  void deleteExpense(ExpenseItem expense) {
    overAllExpenseList.remove(expense);
    notifyListeners();
  }

  // get weekday (mot, tue, etc) from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  // get the date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today date
    DateTime today = DateTime.now();

    // go backward from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  conver all list of expenses into a daily expnses summary
  e.g

  overallExpenseList = 
  [
    [food,20230130,$10],
    [hat,20230130,$15],
    [drink,20230131,$1],
    
  ]

  dailyExpenseSummary = [
    [20230130,$25],
    [20230131,$1],
  ]

  */
  Map<String, double> calculationDailyExpenseSummary() {
    Map<String,double> dailyExpenseSummary ={

    };

    for (var expense in overAllExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        dailyExpenseSummary[date] = currentAmount + amount;
      }else{
        dailyExpenseSummary.addAll({date:amount});
      }
    }
    return dailyExpenseSummary;
  }
}
