// file: main.dart
import 'package:flutter/material.dart';
import 'forget_password_screen.dart'; // Import màn hình đầu tiên

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Nền trắng toàn app
        fontFamily: 'Roboto',
      ),
      // Bắt đầu ngay tại màn hình Quên mật khẩu
      home: const ForgetPasswordScreen(),
    );
  }
}
