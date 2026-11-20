import 'package:flutter/material.dart';

import '../data/sample_food.dart';
import '../models/food_item.dart';
import '../theme.dart';
import '../widgets/food_card.dart';
import 'create_edit_screen.dart';
import 'food_list_screen.dart';
import 'login_screen.dart';

// DASHBOARD: summary tab + food list tab + profile tab, with
// a BottomNavigationBar. It also owns the list of items (hard-coded start).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;
  final List<FoodItem> _items = List.of(sampleFood);

  // Open the form. Navigator.push waits for Navigator.pop to return the item.
  Future<void> _openForm({FoodItem? existing, int? index}) async {
    final result = await Navigator.push<FoodItem>(
      context,
      MaterialPageRoute(builder: (_) => CreateEditScreen(item: existing)),
    );
    if (result != null) {
      setState(() {
        if (index == null) {
          _items.insert(0, result);
        } else {
          _items[index] = result;
        }
      });
    }
  }

  void _delete(int index) {
    setState(() => _items.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Listing removed')),
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Dashboard', 'Food Near You', 'Profile'];
    final pages = <Widget>[
      _HomeTab(
        items: _items,
        onSeeAll: () => setState(() => _index = 1),
        onOpen: (i) => _openForm(existing: _items[i], index: i),
      ),
      FoodListScreen(
        items: _items,
        onEdit: (i) => _openForm(existing: _items[i], index: i),
        onDelete: _delete,
      ),
      _ProfileTab(onLogout: _logout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(index: _index, children: pages),
      floatingActionButton: _index == 2
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openForm(),
              backgroundColor: kAccent,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Share Food'),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: kPrimary,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Food List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ---------- Dashboard summary tab ----------
class _HomeTab extends StatelessWidget {
  final List<FoodItem> items;
  final VoidCallback onSeeAll;
  final void Function(int index) onOpen;

  const _HomeTab({
    required this.items,
    required this.onSeeAll,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final latest = items.take(3).toList();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Neighbour!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              const Text(
                'Together we can end food waste and hunger.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              // Summary section: three cards sharing the width with Expanded
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.fastfood,
                      value: '${items.length}',
                      label: 'Active listings',
                    ),
                  ),
                  const Expanded(
                    child: _StatCard(
                      icon: Icons.favorite,
                      value: '128',
                      label: 'Meals saved',
                    ),
                  ),
                  const Expanded(
                    child: _StatCard(
                      icon: Icons.groups,
                      value: '12',
                      label: 'Donors',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest listings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: onSeeAll,
                    child: const Text('See all'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < latest.length; i++)
                FoodCard(item: latest[i], onTap: () => onOpen(i)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: kAccent, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ---------- Profile tab ----------
class _ProfileTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _ProfileTab({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: kPrimary,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Community Member',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              const Text(
                'member@surplusfood.com',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
