import 'package:flutter/material.dart';
import 'package:steam_calculator/homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 11, 44, 100),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IVA Steam',
      home: const HomePage(),
    );
  }
}
