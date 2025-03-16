import 'package:flutter/material.dart';

class NumberTypeScreen extends StatefulWidget {
  @override
  _NumberTypeScreenState createState() => _NumberTypeScreenState();
}

class _NumberTypeScreenState extends State<NumberTypeScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = "";

  bool _isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
      if (num % i == 0) return false;
    }
    return true;
  }

  void _analyzeNumber() {
    String input = _numberController.text;
    if (input.isEmpty) {
      setState(() {
        _result = "Masukkan angka terlebih dahulu!";
      });
      return;
    }

    int? number = int.tryParse(input);
    if (number == null) {
      setState(() {
        _result = "Masukkan angka yang valid!";
      });
      return;
    }

    List<String> properties = [];
    if (number > 0) {
      properties.add("Positif");
    } else if (number < 0) {
      properties.add("Negatif");
    }

    if (number % 2 == 0) {
      properties.add("Genap");
    } else {
      properties.add("Ganjil");
    }

    if (_isPrime(number)) {
      properties.add("Bilangan Prima");
    }

    setState(() {
      _result = "Angka $number adalah: ${properties.join(', ')}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jenis Bilangan")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Masukkan angka"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: _analyzeNumber, child: Text("Cek Jenis Bilangan")),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
