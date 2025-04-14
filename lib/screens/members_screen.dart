import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  final List<Map<String, String>> members = [
    {"name": "Kaifa Ahlal Katamsyi", "description": "123220006"},
    {"name": "Bayu Prasetya Wijaya", "description": "123220002"},
    {"name": "Alfat Rahman", "description": "123220001"},
    {"name": "Rio Rivaldo Sinuhaji", "description": "123220005"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DAFTAR ANGGOTA"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A90E2),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white.withOpacity(0.95),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      member["description"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline,
                            color: Colors.blueGrey),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Detail ${member["name"]}'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
