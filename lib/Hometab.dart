
import 'package:esgbasics/profile.dart';
import 'package:esgbasics/scan.dart';
import 'package:flutter/material.dart';

import 'Video.dart';
import 'home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xFFCBFF6B),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavItem(0, 'Home', 'assets/images/home.png'),
          buildBottomNavItem(1, 'Video', 'assets/images/video.png'),
          buildBottomNavItem(2, 'Scan', 'assets/images/Scan.png'),
          buildBottomNavItem(3, 'Profile', 'assets/images/profile.png'),
        ],
      ),
    );
  }

  Widget buildBottomNavItem(int index, String label, String iconPath) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Image.asset(
                iconPath,
                width: 35,
                height: 35,
                color: widget.currentIndex == index
                    ? Color(0xFF57EA44) // Change selected color as needed
                    : Colors.black, // Change unselected color as needed
              ),
              /*Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 1,
                  color: Colors.grey, // Change color as needed
                ),
              ),*/
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins_semi',
              color: widget.currentIndex == index
                  ? Color(0xFF57EA44) // Change selected color as needed
                  : Colors.black, // Change unselected color as needed
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    Home(),
    VideoPage(),
    ScanPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

