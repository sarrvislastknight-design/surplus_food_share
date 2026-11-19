import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';
import 'theme.dart';

void main() => runApp(const SurplusFoodApp());

class SurplusFoodApp extends StatelessWidget {
  const SurplusFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surplus Food Share',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // the single ThemeData, applied to every screen
      home: const OnboardingScreen(),
    );
  }
}
