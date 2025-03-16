import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TextEditingController _yearController = TextEditingController();
  String _result = "";

  void _convertTime() {
    String input = _yearController.text;
    if (input.isEmpty) {
      setState(() {
        _result = "Masukkan tahun terlebih dahulu!";
      });
      return;
    }

    int? years = int.tryParse(input);
    if (years == null || years < 0) {
      setState(() {
        _result = "Masukkan angka yang valid!";
      });
      return;
    }

    int days = years * 365;
    int hours = days * 24;
    int minutes = hours * 60;
    int seconds = minutes * 60;

    setState(() {
      _result = "$years tahun = $hours jam, $minutes menit, $seconds detik";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Waktu")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Masukkan tahun"),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _convertTime, child: Text("Konversi")),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
