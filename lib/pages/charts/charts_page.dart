import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../providers/expense_provider.dart';
import '../../providers/category_provider.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Providers
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    // Bu ay
    final now = DateTime.now();
    final categoryData = expenseProvider.getCategoryTotalsForMonth(
      now.month,
      now.year,
    );

    // Kategoriler
    final categories = categoryProvider.categories;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Harcamalar Analizi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bu Ayın Harcama Dağılımı",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  if (categoryData.isEmpty)
                    const Center(
                      child: Text(
                        "Bu ay için harcama bulunamadı.",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  else
                    SizedBox(
                      height: 260,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,

                          sections: categoryData.entries.map((e) {
                            // Kategoriyi buluyoruz
                            final cat = categories.firstWhere(
                              (c) => c.name == e.key,
                              orElse: () => categories.firstWhere(
                                (c) => c.name == "Diğer",
                                orElse: () => categories.first,
                              ),
                            );

                            return PieChartSectionData(
                              color: Color(cat.color),
                              title:
                                  "${e.key}\n${e.value.toStringAsFixed(0)} ₺",
                              value: e.value,
                              radius: 55,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
