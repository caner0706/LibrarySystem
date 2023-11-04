import 'package:flutter/material.dart';
import '../Account Page/account.dart';
import '../Books Information 2/kitaplar2.dart';
import '../Books Information/books.dart';
import '../Reservation Page/kitaplarım.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          Kitaplar2(),
          Kitaplarim(),
          Hesabim(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(0, Icons.book, 'Kitaplar'),
          _buildIcon(1, Icons.history, 'Kitaplarım'),
          _buildIcon(2, Icons.account_circle_outlined, 'Hesabım'),
        ],
      ),
    );
  }
}
