import 'package:finans_takip/pages/expense/add_expense_page.dart';
import 'package:finans_takip/pages/settings/set_budget_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finans_takip/providers/expense_provider.dart';
import 'package:finans_takip/providers/category_provider.dart';
import 'package:finans_takip/widgets/budget_card.dart';
import 'package:finans_takip/widgets/latest_expenses_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    final expenses = expenseProvider.expenses;
    final recentExpenses = expenses.reversed.take(3).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade300,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpensePage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Ayın Bütçesi:",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SetBudgetPage()),
                    ),
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
              ),

              SizedBox(height: 20),
              BudgetCard(),

              SizedBox(height: 25),
              Text(
                "Son Harcamalar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12),

              Expanded(
                child: recentExpenses.isEmpty
                    ? Center(
                        child: Text(
                          "Henüz harcama eklenmedi.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: recentExpenses.length,
                        itemBuilder: (context, index) {
                          final exp = recentExpenses[index];

                          final category = categoryProvider.categories
                              .firstWhere(
                                (c) => c.id == exp.categoryId,
                                orElse: () => categoryProvider.categories[0],
                              )
                              .name;

                          return LatestExpensesCard(
                            category: category,
                            amount: exp.amount,
                            date:
                                "${exp.date.day}.${exp.date.month}.${exp.date.year}",
                            icon: Icons.category,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
