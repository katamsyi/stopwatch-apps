import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal
import 'stopwatch_screen.dart';
import 'number_type_screen.dart';
import 'tracking_lbs_screen.dart';
import 'time_conversion_screen.dart';
import 'recommendation_screen.dart';
import 'login_screen.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = "";
  String _currentTime = ""; // Menyimpan waktu dan tanggal terkini
  late Timer _timer; // Timer untuk memperbarui waktu

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _startClock(); // Memulai jam berjalan saat halaman dibuka
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? "";
    });
  }

  // Fungsi untuk memperbarui waktu dan tanggal terkini
  void _updateTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        DateFormat('EEEE, dd MMMM yyyy\nHH:mm:ss').format(now);
    setState(() {
      _currentTime = formattedTime; // Memperbarui waktu setiap detik
    });
  }

  // Memulai timer untuk memperbarui waktu setiap detik
  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(); // Memperbarui waktu setiap detik
    });
  }

  // Berhenti dari timer saat halaman di-dispose
  @override
  void dispose() {
    _timer.cancel(); // Menghentikan timer saat halaman ditutup
    super.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white.withOpacity(0.95),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black26,
                      offset: Offset(1, 2),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Halo, $_username! 👋",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 2),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Menampilkan waktu dan tanggal terkini yang akan diperbarui setiap detik
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _currentTime, // Waktu yang akan diperbarui setiap detik
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, // Agar di tengah
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  children: [
                    buildMenuCard("Stopwatch", Icons.timer, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StopwatchScreen()));
                    }),
                    buildMenuCard("Jenis Bilangan", Icons.format_list_numbered,
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NumberTypeScreen()));
                    }),
                    buildMenuCard("Tracking LBS", Icons.location_on, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackingLBSScreen()));
                    }),
                    buildMenuCard("Konversi Waktu", Icons.access_time, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimeConversionScreen()));
                    }),
                    buildMenuCard("Rekomendasi Situs", Icons.link, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendationScreen()));
                    }),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                        onPressed: () => _logout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(), // Static BottomNav without animation
    );
  }
}
