import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme.dart';

IconData iconForCategory(String category) {
  switch (category) {
    case 'Cooked meals':
      return Icons.rice_bowl;
    case 'Bakery':
      return Icons.bakery_dining;
    case 'Fruits & vegetables':
      return Icons.eco;
    case 'Packaged food':
      return Icons.inventory_2;
    case 'Drinks':
      return Icons.local_drink;
    default:
      return Icons.fastfood;
  }
}

// One listing card, reused on the Dashboard and the Food list.
class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const FoodCard({super.key, required this.item, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    // Container with BoxDecoration: rounded corners, border and shadow
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        // InkWell: gesture handling with a ripple effect (onTap)
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    iconForCategory(item.category),
                    color: kPrimary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.place,
                              size: 14, color: Colors.black45),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.quantity}  •  Pickup: ${item.pickupTime}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: Colors.red.shade300),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
