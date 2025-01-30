import 'package:flutter/material.dart';
import 'package:reminder/screens/entity_screen.dart';
import 'package:reminder/screens/event_screen.dart';
import 'package:reminder/widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          EventScreen(),
          EntityScreen(),
        ],
      ),
      bottomNavigationBar: Menu(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        hasBorder: true,
        icons: const [Icons.home_outlined, Icons.person_outlined],
      ),
    );
  }
}
