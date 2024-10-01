import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_push_app/firebase_options.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    
    await _firebaseMessaging.requestPermission();
    
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    // TODO: Enviar este token a tu servidor
    
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}