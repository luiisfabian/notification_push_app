import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_push_app/firebase_options.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    // TODO: Enviar este token a tu servidor
    if (fCMToken != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

// name of the collection to be deleted
      String collectionName = "registers";

// Get a reference to the collection
      CollectionReference collectionRef = firestore.collection(collectionName);

// Delete the collection
      await collectionRef.get().then((snapshot) {
        print(snapshot.docs);
        for (DocumentSnapshot register in snapshot.docs) {
          register.reference.delete();
        }
      });

      CollectionReference registers =
          FirebaseFirestore.instance.collection('registers');
      registers
          .doc('dave') // Especifica el nombre del documento
          .set({
            'register': fCMToken, // John Doe
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

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
