import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finans_takip/providers/budget_provider.dart';
import 'package:finans_takip/providers/expense_provider.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final now = DateTime.now();
    final spentThisMonth = expenseProvider.getTotalForMonth(
      now.month,
      now.year,
    );
    final totalBudget = budgetProvider.budget?.amount ?? 0;
    final percent = totalBudget == 0 ? 0 : (spentThisMonth / totalBudget);
    final remaingMoney = totalBudget - spentThisMonth;
    final isOverBudget = spentThisMonth > totalBudget;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Toplam Bütçe: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "${totalBudget.toStringAsFixed(2)} TL",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Harcanan: ",
            style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            "${spentThisMonth.toStringAsFixed(2)} TL",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Kalan: ",
            style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            "${remaingMoney.toStringAsFixed(2)} TL",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percent.clamp(0, 1).toDouble(),
                    minHeight: 10,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(
                      isOverBudget ? Colors.redAccent : Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                "%${(percent * 100).clamp(0, 100).toStringAsFixed(0)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
