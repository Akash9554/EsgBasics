
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../profile.dart';
import '../GinnerTab/GinnerListofallvideo.dart';




import '../../../Video.dart';
import 'Spinnerhome.dart';

class CustomBottomNavigationBara extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBara({super.key, required this.currentIndex, required this.onTap});

  @override
  _CustomBottomNavigationBaraState createState() =>
      _CustomBottomNavigationBaraState();
}

class _CustomBottomNavigationBaraState extends State<CustomBottomNavigationBara> {
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
                    ? const Color(0xFF57EA44) // Change selected color as needed
                    : Colors.black, // Change unselected color as needed
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins_semi',
              color: widget.currentIndex == index
                  ? const Color(0xFF57EA44) // Change selected color as needed
                  : Colors.black, // Change unselected color as needed
            ),
          ),
        ],
      ),
    );
  }
}

class Spinnertab extends StatefulWidget {
  const Spinnertab({super.key});

  @override
  _SpinnertabState createState() => _SpinnertabState();
}

class _SpinnertabState extends State<Spinnertab> {
  final getStorge = GetStorage();
  int _currentIndex = 0;
  final List<Widget> _tabs = [
     SpinnerHome(),
    GinnerVideoList(),
     Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBara(
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

