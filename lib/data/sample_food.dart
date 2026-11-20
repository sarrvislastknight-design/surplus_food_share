import '../models/food_item.dart';

// Hard-coded data (allowed in Practical 1). The database comes in Practical 2.
const List<FoodItem> sampleFood = [
  FoodItem(
    title: 'Chicken Biryani',
    quantity: '10 packs',
    location: 'Restoran Selera, Kuala Lumpur',
    pickupTime: '8:00 PM today',
    category: 'Cooked meals',
  ),
  FoodItem(
    title: 'Assorted Bread & Buns',
    quantity: '25 pieces',
    location: 'Sunrise Bakery, Cheras',
    pickupTime: '9:30 PM today',
    category: 'Bakery',
  ),
  FoodItem(
    title: 'Fresh Vegetables Box',
    quantity: '5 kg',
    location: 'Pasar Tani, Petaling Jaya',
    pickupTime: '6:00 PM today',
    category: 'Fruits & vegetables',
  ),
  FoodItem(
    title: 'Canned Sardines & Noodles',
    quantity: '20 items',
    location: 'Kedai Runcit Ali, Ampang',
    pickupTime: 'Tomorrow 10:00 AM',
    category: 'Packaged food',
  ),
  FoodItem(
    title: 'Packet Drinks',
    quantity: '30 packs',
    location: 'Cafe Bintang, Bangsar',
    pickupTime: 'Tomorrow 12:00 PM',
    category: 'Drinks',
  ),
];
