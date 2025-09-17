import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission to receive notifications
    await _firebaseMessaging.requestPermission();

    // Get the FCM token for this device
    await _firebaseMessaging.getToken();
    // TODO: Send this token to your server

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // TODO: Handle the incoming message
    });
  }
}
