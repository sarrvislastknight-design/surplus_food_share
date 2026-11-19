import 'package:flutter/material.dart';

// PLACEHOLDER - Person B replaces this file with the real Dashboard
// (summary + BottomNavigationBar, Main list with ListView.builder,
// and the Create/Edit screen). It only exists so that Login compiles.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(child: Text('Dashboard - built by Person B')),
    );
  }
}
