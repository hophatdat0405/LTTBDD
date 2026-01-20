import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color primaryBlue = Color(0xFF00A9F4);
  static const Color cardRedBg = Color(0xFFFEE8E7);
  static const Color cardRedStatus = Color(0xFFE57373);
  static const Color cardYellowBg = Color(0xFFFFF9E6);
  static const Color cardYellowStatus = Color(0xFFFBC02D);
  static const Color cardBlueBg = Color(0xFFE0F7FA);
  static const Color cardBlueStatus = Color(0xFF4DD0E1);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTH SmartTasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
