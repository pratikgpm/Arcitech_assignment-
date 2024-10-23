import 'package:arcitech/features/auth/services/firebase_messagign_api.dart';
import 'package:arcitech/features/auth/view/login_page.dart';
import 'package:arcitech/features/home/view/notificationScreen.dart';
import 'package:arcitech/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arcitech/core/theme/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotification();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: loginView(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => NotificatioScreen(),
      },
    );
  }
}
