import 'package:flutter/material.dart';
import 'screens.dart';

void main() => runApp(const Reserva7App());

const green = Color(0xFF0B3D36);
const cream = Color(0xFFF6F5F0);
const mint = Color(0xFFE2ECE7);
const gold = Color(0xFFC7A66A);

class Reserva7App extends StatelessWidget {
  const Reserva7App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Reserva7',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(seedColor: green),
      fontFamily: 'Arial',
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: green)),
      ),
    ),
    home: const SplashPage(),
  );
}