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
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Members"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (index == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MembersScreen()));
        } else if (index == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HelpScreen()));
        }
      },
    );
  }
}
