import 'package:arcitech/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {
  final _firebasemMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebasemMessaging.requestPermission();
    final fToken = await _firebasemMessaging.getToken();
    //here you can get a token to use in firebase
    print(fToken);
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future<void> initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
