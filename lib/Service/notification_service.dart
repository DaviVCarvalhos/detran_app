import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService(this.navigatorKey);

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Configurações de notificação: ${settings.authorizationStatus}');

    String? token = await _firebaseMessaging.getToken();
    print("Token do dispositivo para FCM: $token");

    if (token != null) {
      await _storeTokenLocally(token);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title ?? 'Título';
        String body = message.notification!.body ?? 'Mensagem';

        print("Notificação recebida: $title - $body");

        _showNotificationSnackbar(navigatorKey.currentContext, title, body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        print("Dados ao clicar na notificação: ${message.data}");
        _handleNotificationNavigation(message.data);
      }
    });
  }

  void _showNotificationSnackbar(
      BuildContext? context, String title, String body) {
    if (context == null) return;

    final snackBar = SnackBar(
      content: Text("$title\n$body"),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Abrir',
        onPressed: () {
          navigatorKey.currentState?.pushNamed('/infracoes');
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    String? route = data['routes'];

    if (route != null) {
      if (!navigatorKey.currentState!.mounted) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          route,
          (Route<dynamic> route) => false,
        );
      } else {
        navigatorKey.currentState?.pushNamed(route);
      }
    }
  }

  Future<void> _storeTokenLocally(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_token', token);
    print("Token armazenado localmente: $token");
  }
}
