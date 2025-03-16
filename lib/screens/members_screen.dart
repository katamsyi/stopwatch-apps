import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Anggota")),
      body: ListView(
        children: [
          ListTile(
              title: Text("Anggota 1"), subtitle: Text("Deskripsi Anggota 1")),
          ListTile(
              title: Text("Anggota 2"), subtitle: Text("Deskripsi Anggota 2")),
          ListTile(
              title: Text("Anggota 3"), subtitle: Text("Deskripsi Anggota 3")),
          ListTile(
              title: Text("Anggota 4"), subtitle: Text("Deskripsi Anggota 4")),
        ],
      ),
    );
  }
}
