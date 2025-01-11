import 'package:flutter/material.dart';
import 'package:reminder/screens/entity_screen.dart';
import 'package:reminder/screens/event_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageView(
        children: [
          EventScreen(),
          EntityScreen(),
        ],
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  final List<Widget> children;

  const HomePageView({super.key, required this.children});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);

    pageIndex;
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: widget.children,
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      pageIndex = currentPageIndex;
    });
  }
}
