import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationScreen extends StatelessWidget {
  final List<Map<String, String>> recommendations = [
    {
      "title": "Flutter Official Docs",
      "url": "https://docs.flutter.dev",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png"
    },
    {
      "title": "Dart Programming Language",
      "url": "https://dart.dev",
      "image":
          "https://dart.dev/assets/shared/dart/logo+text/horizontal/white-e71fb382b95004058b44c53063f92ddc6b4cc26d5aa180d4c7f80b60778827b3.svg"
    },
    {
      "title": "Stack Overflow - Flutter",
      "url": "https://stackoverflow.com/questions/tagged/flutter",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/e/ef/Stack_Overflow_icon.svg"
    },
    {
      "title": "GitHub - Flutter Repository",
      "url": "https://github.com/flutter/flutter",
      "image":
          "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
    },
  ];

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rekomendasi Situs")),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final site = recommendations[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(site["image"]!,
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text(site["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(site["url"]!),
              trailing: Icon(Icons.open_in_new),
              onTap: () => _launchURL(site["url"]!),
            ),
          );
        },
      ),
    );
  }
}
