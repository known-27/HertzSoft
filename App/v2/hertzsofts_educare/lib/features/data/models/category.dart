import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final String filterTag;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.filterTag,
  });
}

// Predefined categories
class CategoryData {
  static const List<Category> categories = [
    Category(
      id: '1',
      name: 'Workshop',
      icon: Icons.construction,
      filterTag: 'workshop',
    ),
    Category(
      id: '2',
      name: 'Short Term Courses',
      icon: Icons.school,
      filterTag: 'short_term',
    ),
    Category(
      id: '3',
      name: 'Advanced courses',
      icon: Icons.workspace_premium,
      filterTag: 'advanced',
    ),
  ];

  static Category? getCategoryByFilterTag(String filterTag) {
    try {
      return categories.firstWhere((cat) => cat.filterTag == filterTag);
    } catch (e) {
      return null;
    }
  }
}