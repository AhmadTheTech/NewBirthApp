import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_birth/notifications.dart';
import 'package:new_birth/screens/splash.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.notification?.title.toString());
  }
  if (kDebugMode) {
    print(message.notification?.body.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const NewBirth());
}

class NewBirth extends StatefulWidget {
  const NewBirth({super.key});

  @override
  State<NewBirth> createState() => _NewBirthState();
}

class _NewBirthState extends State<NewBirth> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final NotificationServices notificationServices = NotificationServices();
    await notificationServices.initialize();
    notificationServices.onTokenRefresh();
    String? token = await notificationServices.getDeviceToken();
    if (token != null) {
      if (kDebugMode) {
        print("Device Token: $token");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
