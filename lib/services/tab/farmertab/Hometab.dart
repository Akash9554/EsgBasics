
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Listofallvideo.dart';
import '../../../profile.dart';
import 'home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final getStorge = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color(0xFFCBFF6B),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavItem(0, 'Home', 'assets/images/home.png'),
          buildBottomNavItem(1, 'Video', 'assets/images/video.png'),
          buildBottomNavItem(2, 'Profile', 'assets/images/profile.png'),
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
                    ? const Color(0xFF57EA44)
                    : Colors.black,
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins_semi',
              color: widget.currentIndex == index
                  ? const Color(0xFF57EA44)
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final getStorge = GetStorage();
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const Home(),
    const VideoList(),
    const Profile(),
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

