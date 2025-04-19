import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingLBSScreen extends StatefulWidget {
  @override
  _TrackingLBSScreenState createState() => _TrackingLBSScreenState();
}

class _TrackingLBSScreenState extends State<TrackingLBSScreen> {
  String _locationMessage = "";
  bool _isValid = false;
  double _latitude = 0.0;
  double _longitude = 0.0;

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi tidak aktif.";
        _isValid = false;
      });
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Izin lokasi ditolak.";
          _isValid = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Izin lokasi ditolak secara permanen.";
        _isValid = false;
      });
      return;
    }

    // Mendapatkan posisi dengan akurasi tinggi
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best); // Akurasi terbaik

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _locationMessage = "Latitude: ${_latitude}\nLongitude: ${_longitude}";
      _isValid = true;
    });
  }

// Fungsi untuk membuka Google Maps
  Future<void> _openMap(double latitude, double longitude) async {
    final String googleMapsUrl =
        "https://www.google.com/maps?q=$latitude,$longitude";
    final Uri googleMapsUri = Uri.parse(googleMapsUrl);

    // Use launchUrl instead of canLaunch and launch methods.
    if (await launchUrl(googleMapsUri)) {
      // Successfully opened the map
    } else {
      throw 'Tidak dapat membuka Google Maps.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRACKING LBS"),
        backgroundColor: const Color(0xFF4A90E2),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_locationMessage.isNotEmpty)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: _isValid ? Colors.white : Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _isValid
                                ? Icons.location_on
                                : Icons.warning_amber_rounded,
                            size: 28,
                            color: _isValid ? Colors.blue : Colors.red,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _locationMessage,
                              style: TextStyle(
                                fontSize: 16,
                                color: _isValid
                                    ? Colors.black87
                                    : Colors.red.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _getCurrentLocation,
                  icon: const Icon(Icons.my_location),
                  label: const Text("Dapatkan Lokasi Sekarang"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isValid)
                  ElevatedButton.icon(
                    onPressed: () => _openMap(_latitude, _longitude),
                    icon: const Icon(Icons.directions),
                    label: const Text("Buka di Google Maps"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
