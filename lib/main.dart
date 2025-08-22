import 'package:flutter/material.dart';
import 'package:stockage_app/acceuil.dart';
import 'package:stockage_app/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AcceilPage(),
    );
  }
}
