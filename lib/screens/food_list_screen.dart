import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../widgets/food_card.dart';

// MAIN FEATURE SCREEN: scrolling list of surplus food listings.
class FoodListScreen extends StatelessWidget {
  final List<FoodItem> items;
  final void Function(int index) onEdit;
  final void Function(int index) onDelete;

  const FoodListScreen({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No food listed yet.\nTap "Share Food" to add one.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        // ListView.builder builds each card only when it scrolls into view
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return FoodCard(
              item: items[index],
              onTap: () => onEdit(index),
              onDelete: () => onDelete(index),
            );
          },
        ),
      ),
    );
  }
}
