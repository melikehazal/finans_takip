import 'package:finans_takip/pages/categories/category_page.dart';
import 'package:finans_takip/pages/expense/add_expense_page.dart';
import 'package:finans_takip/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:finans_takip/pages/main/main_screen.dart';
import 'package:finans_takip/providers/category_provider.dart';
import 'package:finans_takip/providers/expense_provider.dart';
import 'package:finans_takip/providers/budget_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Kişisel Finans Takip',

      home: const HomePage(),
    );
  }
}
