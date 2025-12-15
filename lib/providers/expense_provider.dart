import 'package:finans_takip/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> _expenses = []; //private bir liste
  List<ExpenseModel> get expenses =>
      _expenses; //UI görebilsin ama değiştiremesin

  void addExpense(ExpenseModel expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(ExpenseModel expense) {
    _expenses.remove(expense);
    notifyListeners();
  }

  //Belirli bir aya ait harcamaları listeler.
  List<ExpenseModel> getExpensesForMonth(int month, int year) {
    return _expenses.where((expense) {
      return expense.date.month == month && expense.date.year == year;
    }).toList();
  }

  //Belirli bir kategorideki harcamaları döndüren fonksiyon
  List<ExpenseModel> getExpensesForCategory(
    String categoryId,
    int month,
    int year,
  ) {
    return _expenses.where((expense) {
      return expense.categoryId == categoryId &&
          expense.date.month == month &&
          expense.date.year == year;
    }).toList();
  }

  //Belirli bir ayda toplam ne kadar harcandı?
  double getTotalForMonth(int month, int year) {
    List<ExpenseModel> monthlyList = getExpensesForMonth(month, year);
    double total = 0;
    for (var expense in monthlyList) {
      total = total + expense.amount;
    }
    return total;
  }

  double getTotalForCategory(int month, int year, String categoryId) {
    List<ExpenseModel> categoryList = getExpensesForCategory(
      categoryId,
      month,
      year,
    );

    double total = 0;
    for (var expense in categoryList) {
      total = total + expense.amount;
    }
    return total;
  }

  Map<String, double> getMonthlyTotals() {
    Map<String, double> monthlyTotals = {};

    for (var expense in expenses) {
      final year = expense.date.year;
      final month = expense.date.month;

      final key = "$year-${month.toString().padLeft(2, '0')}";

      if (!monthlyTotals.containsKey(key)) {
        monthlyTotals[key] = expense.amount;
      } else {
        monthlyTotals[key] = monthlyTotals[key]! + expense.amount;
      }
    }
    return monthlyTotals;
  }

  Map<String, double> getCategoryTotalsForMonth(int month, int year) {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      if (expense.date.month == month && expense.date.year == year) {
        final category = expense.categoryId;

        if (!categoryTotals.containsKey(category)) {
          categoryTotals[category] = expense.amount;
        } else {
          categoryTotals[category] = categoryTotals[category]! + expense.amount;
        }
      }
    }

    return categoryTotals;
  }
}
