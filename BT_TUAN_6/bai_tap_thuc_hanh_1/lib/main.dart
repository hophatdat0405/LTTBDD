import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart'; // Import Analytics
import 'login_screen.dart';
import 'notification_service.dart'; // Import service vừa tạo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Khởi tạo dịch vụ thông báo
  await NotificationService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Tạo đối tượng theo dõi Analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      // CẤU HÌNH QUAN TRỌNG ĐỂ DASHBOARD NHẬY HƠN
      navigatorObservers: [observer],
      home: const LoginScreen(),
    );
  }
}
