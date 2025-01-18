import 'package:flutter/material.dart';
import 'package:reminder/widgets/entities_form.dart';
import 'package:reminder/widgets/menu.dart';

class EntitiesFormPage extends StatefulWidget {
  const EntitiesFormPage({super.key});

  @override
  State<EntitiesFormPage> createState() => _EntitiesFormPageState();
}

class _EntitiesFormPageState extends State<EntitiesFormPage> {
  int _selectedIndex = 0;
  late PageController _pageFormController;
  @override
  void initState() {
    super.initState();
    _pageFormController = PageController();
  }

  @override
  void dispose() {
    _pageFormController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageFormController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Menu(
          selectedIndex: _selectedIndex,
          onItemTapped: onItemTapped,
          icons: const [
            Icons.person_outlined,
            Icons.business_center_outlined,
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: PageView(
            controller: _pageFormController,
            children: const [
              FormEntity(),
              FormEntity(),
            ],
          ),
        ),
      ],
    );
  }
}
