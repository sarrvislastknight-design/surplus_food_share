import 'package:flutter/material.dart';

import '../theme.dart';
import 'login_screen.dart';

// Simple data holder for one onboarding page.
class _OnboardData {
  final IconData icon;
  final String title;
  final String text;
  const _OnboardData(this.icon, this.title, this.text);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const List<_OnboardData> _pages = [
    _OnboardData(
      Icons.restaurant,
      'Stop Food Waste',
      'Restaurants, shops and families throw away good food every day. '
          'Surplus Food Share turns that waste into meals.',
    ),
    _OnboardData(
      Icons.add_location_alt,
      'Share Your Surplus',
      'Post leftover food in seconds: what it is, how much, '
          'where to collect it and until when.',
    ),
    _OnboardData(
      Icons.volunteer_activism,
      'Help Your Community',
      'Browse food shared near you and collect it for free. '
          'Together we move towards Zero Hunger (SDG 2).',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Replace onboarding with Login so the back button does not return here.
  void _finish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _next() {
    if (_page == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  final p = _pages[index];
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Container with BoxDecoration: circle, border, shadow
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              shape: BoxShape.circle,
                              border: Border.all(color: kPrimary, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Icon(p.icon, size: 80, color: kPrimary),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            p.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 16),
                          // Styled Text with TextStyle
                          Text(
                            p.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Page indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final active = _page == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  width: active ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? kPrimary : Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: _next,
                child: Text(
                  _page == _pages.length - 1 ? 'Get Started' : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
