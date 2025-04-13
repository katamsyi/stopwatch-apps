import 'package:flutter/material.dart';

class NumberTypeScreen extends StatefulWidget {
  @override
  _NumberTypeScreenState createState() => _NumberTypeScreenState();
}

class _NumberTypeScreenState extends State<NumberTypeScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = "";
  bool _isValid = true;

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
        _isValid = false;
      });
      return;
    }

    int? number = int.tryParse(input);
    if (number == null) {
      setState(() {
        _result = "Masukkan angka yang valid!";
        _isValid = false;
      });
      return;
    }

    List<String> properties = [];
    if (number > 0) {
      properties.add("Positif");
    } else if (number < 0) {
      properties.add("Negatif");
    } else {
      properties.add("Nol");
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
      _isValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JENIS BILANGAN"),
        backgroundColor: const Color(0xFF4A90E2),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Masukkan angka",
                    prefixIcon: const Icon(Icons.confirmation_number),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _analyzeNumber,
                  icon: const Icon(Icons.search),
                  label: const Text("Cek Jenis Bilangan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_result.isNotEmpty)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: _isValid ? Colors.white : Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            _isValid ? Icons.check_circle : Icons.error,
                            color: _isValid ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _result,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    _isValid ? Colors.black87 : Colors.red[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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
