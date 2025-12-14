
import 'package:flutter/material.dart';

class CategoryIconMapper {
  static const Map<String, IconData> _icons = {
    // Food & daily
    'restaurant': Icons.restaurant,
    'shopping_cart': Icons.shopping_cart,
    'local_gas_station': Icons.local_gas_station,

    // Transport & travel
    'directions_car': Icons.directions_car,
    'flight': Icons.flight,

    // Bills & finance
    'receipt_long': Icons.receipt_long,
    'account_balance': Icons.account_balance,
    'security': Icons.security,
    'savings': Icons.savings,
    'home': Icons.home,

    // Lifestyle
    'shopping_bag': Icons.shopping_bag,
    'movie': Icons.movie,
    'subscriptions': Icons.subscriptions,
    'fitness_center': Icons.fitness_center,
    'spa': Icons.spa,

    // Personal
    'local_hospital': Icons.local_hospital,
    'school': Icons.school,

    // Others
    'card_giftcard': Icons.card_giftcard,
    'category': Icons.category,
  };

  static IconData get(String iconName) {
    return _icons[iconName] ?? Icons.category;
  }
}
