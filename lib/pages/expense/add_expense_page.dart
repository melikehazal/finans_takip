import 'package:finans_takip/pages/categories/category_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finans_takip/providers/expense_provider.dart';
import 'package:finans_takip/models/expense_model.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final softGrey = Colors.grey.shade200;
    final borderRadius = BorderRadius.circular(14);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Harcama Ekle",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // TUTAR
            Text(
              "Tutar",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: softGrey,
                hintText: "0.00",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KATEGORİ
            Text(
              "Kategori",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),

            InkWell(
              onTap: () async {
                final selected = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()),
                );
                if (selected != null) {
                  setState(() {
                    selectedCategory = selected;
                  });
                }
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: softGrey,
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Icon(Icons.category, color: Colors.grey.shade700),
                    const SizedBox(width: 12),
                    Text(
                      selectedCategory ?? "Kategori seç",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Tarih",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),

            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: softGrey,
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? "Tarih seçin"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Açıklama",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: descriptionController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: softGrey,
                hintText: "İsteğe bağlı",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amountText = amountController.text.trim();
                  final descriptionText = descriptionController.text.trim();
                  final category = selectedCategory;
                  final date = selectedDate;

                  // 1) Zorunlu alanlar
                  if (amountText.isEmpty || category == null || date == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Lütfen tüm zorunlu alanları doldurun."),
                      ),
                    );
                    return;
                  }

                  // 2) Sayı kontrolü
                  final amount = double.tryParse(amountText);
                  if (amount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen geçerli bir sayı girin.")),
                    );
                    return;
                  }

                  // 3) Model oluşur
                  final newExpense = ExpenseModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    amount: amount,
                    categoryId: category,
                    description: descriptionText,
                    date: date,
                  );

                  // 4) Provider'a ekle
                  Provider.of<ExpenseProvider>(
                    context,
                    listen: false,
                  ).addExpense(newExpense);

                  // 5) Ekranı kapat
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
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
            ),
          ],
        ),
      ),
    );
  }
}
