import 'package:flutter/material.dart';
import 'package:librarysystem/Books%20Information/books.dart';
import 'package:librarysystem/Reservation%20Page/kitaplar%C4%B1m.dart';

import '../Account Page/account.dart';

class Home_2 extends StatefulWidget {
  const Home_2({super.key});

  @override
  State<Home_2> createState() => _HomeState();
}

class _HomeState extends State<Home_2> {
  late PageController _pageController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIcon(int index, IconData iconData, String text) {
    bool isSelected = index == _currentTab;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : Colors.transparent,
            ),
            child: Icon(
              iconData,
              color: isSelected ? Colors.white : Colors.black,
              size: 30,
            ),
          ),
          Text(text, style: TextStyle(color: isSelected ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        children: [
          Kitaplar(),
          Kitaplarim(),
          Hesabim(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(0, Icons.book, 'Kitaplar'),
          _buildIcon(1, Icons.calendar_month_outlined, 'Rezerve Kitaplar'),
          _buildIcon(2, Icons.account_circle_outlined, 'Hesabım'),
        ],
      ),
    );
  }
}
