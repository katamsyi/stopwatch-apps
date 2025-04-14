import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/members_screen.dart';
import '../screens/help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

class BottomNav extends StatelessWidget {
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // dari kanan ke kiri
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Members"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
      ],
      onTap: (index) {
        if (index == 0) {
          _navigateWithAnimation(context, HomeScreen());
        } else if (index == 1) {
          _navigateWithAnimation(context, MembersScreen());
        } else if (index == 2) {
          _navigateWithAnimation(context, HelpScreen());
        }
      },
    );
  }
}
