import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String icon;
  int color; //argb olarak kaydedeceğiz

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  IconData get iconData {
    switch (icon) {
      case "restaurant":
        return Icons.restaurant;
      case "directions_bus":
        return Icons.directions_bus;
      case "shopping_cart":
        return Icons.shopping_cart;
      case "bolt":
        return Icons.bolt;
      case "sports_esports":
        return Icons.sports_esports;
      default:
        return Icons.help_outline;
    }
  }
}
