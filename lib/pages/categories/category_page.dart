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
        crossAxisCount: 2, //soldan sağa kaç eleman olacak
        crossAxisSpacing: 5, //soldan sağa sutünlar arası boşluk
        mainAxisSpacing: 5, //yukardan aşağı sutünlar arası boşluk
        padding: EdgeInsets.all(
          10,
        ), //her elemanın çevresine verilen boşluk miktarı
        children: categories.map((cat) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, cat.id);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(cat.color),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 40, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    cat.name,
                    style: TextStyle(
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
      ),
    );
  }
}
