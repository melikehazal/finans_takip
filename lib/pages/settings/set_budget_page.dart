import 'package:finans_takip/models/budget_model.dart';
import 'package:finans_takip/providers/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetBudgetPage extends StatefulWidget {
  const SetBudgetPage({super.key});

  @override
  State<SetBudgetPage> createState() => _SetBudgetPageState();
}

class _SetBudgetPageState extends State<SetBudgetPage> {
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Bütçe Ayarla",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "0.00",
                  labelText: "Aylık Bütçenizi Giriniz",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final text = budgetController.text.trim();

                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Lütfen bütçe giriniz.")),
                  );
                  return;
                }

                final amount = double.tryParse(text);
                if (amount == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Geçerli bir sayı girin.")),
                  );
                  return;
                }

                final newBudget = BudgetModel(
                  amount: amount,
                  month: DateTime.now().month,
                  year: DateTime.now().year,
                  spent: 0,
                );

                Provider.of<BudgetProvider>(
                  context,
                  listen: false,
                ).setBudget(newBudget);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Bütçe güncellendi.")));

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Kaydet",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
