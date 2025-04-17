import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/members_screen.dart';
import '../screens/help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // Track current selected tab
  int _selectedIndex = 0;

  // Navigate to the appropriate screen and update index
  void _navigate(BuildContext context, Widget page, int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab index
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Current selected tab index
      selectedItemColor: Colors.blue, // Color for the selected tab icon
      unselectedItemColor: Colors.blue, // Color for unselected tab icons
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Members",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: "Help",
        ),
      ],
      onTap: (index) {
        // Navigate based on the selected index
        if (index == 0) {
          _navigate(context, HomeScreen(), index);
        } else if (index == 1) {
          _navigate(context, MembersScreen(), index);
        } else if (index == 2) {
          _navigate(context, HelpScreen(), index);
        }
      },
    );
  }
}
