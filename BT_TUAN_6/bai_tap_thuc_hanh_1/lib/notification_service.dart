import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Tạo Singleton để gọi ở đâu cũng được
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Hàm khởi tạo (Gọi ở main.dart)
  Future<void> initialize() async {
    // 1. Xin quyền thông báo (Bắt buộc cho Android 13+)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2. Cấu hình icon cho thông báo Android
    // LƯU Ý: Đảm bảo trong android/app/src/main/res/drawable/ có file ic_launcher.png hoặc mipmap
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(initSettings);

    // 3. Lắng nghe tin nhắn từ Firebase khi App đang mở (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
    });

    print("Notification Service Initialized!");
  }

  // Hàm tự hiển thị thông báo (Gọi khi Login thành công)
  Future<void> showLocalNotification({String? title, String? body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel', // ID kênh trùng với AndroidManifest
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond, // ID thông báo (random để không đè)
      title,
      body,
      platformDetails,
    );
  }
}
