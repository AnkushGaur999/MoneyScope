import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/core/constants/app_colors/money_scope_colors_light.dart';
import 'package:money_scope/src/presentation/views/onboarding/pages/first_page.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();

  int _pageIndex = 0;

  final List<Widget> _pages = [
     const FirstPage(),
    const Center(child: Text("Page 2")),
    const Center(child: Text("Page 2")),
  ];



  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MoneyScopeColorsLight.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pages,
            ),
          ),

         if(_pageIndex != 0) Positioned(
            left: 20,
            bottom: 60,
            child: TextButton(onPressed: () {}, child: Text("Previous")),
          ),
          Positioned(
            right: 20,
            bottom: 60,
            child: TextButton(onPressed: () {}, child: Text("Next")),
          ),
        ],
      ),
    );
  }

}
