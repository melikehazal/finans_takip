import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finans_takip/providers/category_provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Kategoriler",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),

      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: EdgeInsets.all(16),

        children: [
          // -------------------- TÜM KATEGORİLER --------------------
          ...categories.map((cat) {
            return InkWell(
              onTap: () => Navigator.pop(context, cat.id),
              borderRadius: BorderRadius.circular(16),

              child: Container(
                decoration: BoxDecoration(
                  color: Color(cat.color),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat.iconData, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          // -------------------- YENİ KATEGORİ KARTI --------------------
          InkWell(
            onTap: () {
              // Yeni kategori ekleme sayfasını burada açacağız
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, size: 48, color: Colors.black87),
                  SizedBox(height: 12),
                  Text(
                    "Yeni Kategori",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
