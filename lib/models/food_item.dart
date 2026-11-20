// Data model: one surplus-food listing.
class FoodItem {
  final String title;
  final String quantity;
  final String location;
  final String pickupTime;
  final String category;

  const FoodItem({
    required this.title,
    required this.quantity,
    required this.location,
    required this.pickupTime,
    required this.category,
  });
}

// Categories shown in the dropdown on the Create / Edit screen.
const List<String> kCategories = [
  'Cooked meals',
  'Bakery',
  'Fruits & vegetables',
  'Packaged food',
  'Drinks',
];
