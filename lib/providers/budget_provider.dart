import 'package:finans_takip/models/budget_model.dart';
import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? _budget;
  BudgetModel? get budget => _budget;

  //Kullanıcının UI üzerinden bir aylık bütçe belirlemesini sağlar.
  void setBudget(BudgetModel budget) {
    _budget = budget;
    notifyListeners();
  }

  //ExpenseProvider’ın hesapladığı aylık toplam harcamayı, bütçedeki spent alanına yaz.
  void updateSpent(double spentValue) {
    _budget?.spent = spentValue;
    notifyListeners();
  }

  double get remaining {
    if (_budget == null) return 0;
    return _budget!.amount - _budget!.spent;
  }

  double get percent {
    if (_budget == null) return 0;
    if (_budget!.amount == 0) return 0;

    return _budget!.spent / _budget!.amount;
  }
}
