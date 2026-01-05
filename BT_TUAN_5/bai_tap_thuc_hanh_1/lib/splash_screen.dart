// file: splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Thư viện để dùng Timer
import 'onboarding_screen.dart'; // Import màn hình onboarding

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Đợi 3 giây rồi chuyển sang màn hình Onboarding
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo UTH (Nếu chưa có ảnh thì dùng Icon hoặc Text tạm)
            Image.asset('assets/images/uth_logo.png', width: 150),

            const SizedBox(height: 20),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006EE9), // Đặt màu ở đây
              ),
            ),
          ],
        ),
      ),
    );
  }
}
