import 'package:flutter/material.dart';
import 'stopwatch_screen.dart';
import 'number_type_screen.dart';
import 'tracking_lbs_screen.dart';
import 'time_conversion_screen.dart';
import 'recommendation_screen.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView(
        children: [
          ListTile(
              title: Text("Stopwatch"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StopwatchScreen()))),
          ListTile(
              title: Text("Jenis Bilangan"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NumberTypeScreen()))),
          ListTile(
              title: Text("Tracking LBS"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrackingLBSScreen()))),
          ListTile(
              title: Text("Konversi Waktu"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TimeConversionScreen()))),
          ListTile(
              title: Text("Rekomendasi Situs"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendationScreen()))),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
