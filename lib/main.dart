import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/albums.dart';
import 'models/apiData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => AlbumsData(),
        builder: (context, child) {
          return const AlbumsPage();
        },
      ),
    );
  }
}
