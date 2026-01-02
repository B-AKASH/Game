import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const CardGameApp());
}

class CardGameApp extends StatelessWidget {
  const CardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'கரணம் கார்டு விளையாட்டு',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const GameScreen(),
    );
  }
}
