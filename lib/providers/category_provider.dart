import 'package:finans_takip/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final List<CategoryModel> _categories = [
    CategoryModel(
      id: "food",
      name: "Yemek",
      icon: "restaurant",
      color: 0xFFE57373, // soft kırmızı
    ),
    CategoryModel(
      id: "transport",
      name: "Ulaşım",
      icon: "directions_bus",
      color: 0xFF64B5F6, // soft mavi
    ),
    CategoryModel(
      id: "market",
      name: "Market",
      icon: "shopping_cart",
      color: 0xFF81C784, // soft yeşil
    ),
    CategoryModel(
      id: "bills",
      name: "Faturalar",
      icon: "bolt",
      color: 0xFFFFD54F, // soft sarı
    ),
    CategoryModel(
      id: "entertainment",
      name: "Eğlence",
      icon: "sports_esports",
      color: 0xFFBA68C8, // soft mor
    ),
  ];
  List<CategoryModel> get categories => _categories;

  //UI’dan gelen yeni kategori modelini alıp mevcut kategori listesine ekler.
  void addCategory(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  void removeCategory(CategoryModel category) {
    _categories.remove(category);
    notifyListeners();
  }
}
