import 'package:myapp/models/expense_item.dart';

class ExpenseData {
  // list of all expenses
  List<ExpenseItem> overAllExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overAllExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpenseList.add(newExpense);
  }

  // delete expnses
  void deleteExpense(ExpenseItem expense) {
    overAllExpenseList.remove(expense);
  }

  // get weekday (mot, tue, etc) from a dateTime object

  // get the date for the start of the week (sunday)

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
}
