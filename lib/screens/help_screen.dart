import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bantuan")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cara Menggunakan Aplikasi:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("1. Login dengan akun Anda."),
            Text("2. Pilih menu yang tersedia di halaman utama."),
            Text("3. Gunakan fitur stopwatch, konversi waktu, dll."),
            Text("4. Untuk keluar, gunakan menu Logout di navigasi bawah."),
          ],
        ),
      ),
    );
  }
}
