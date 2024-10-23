import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificatioScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => NotificatioScreen(),
      );

  const NotificatioScreen({super.key});

  @override
  State<NotificatioScreen> createState() => _NotificatioScreenState();
}

class _NotificatioScreenState extends State<NotificatioScreen> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Pallete.whiteColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shadowColor: Pallete.formFieldGrey,
                color: Pallete.whiteColor,
                child: ListTile(
                  title: Text(
                    message.notification!.title.toString(),
                    style: const TextStyle(
                        color: Pallete.headingFontColr,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(message.notification!.body.toString()),
                ),
              )

              // Text(message.data.toString()),
            ],
          ),
        ));
  }
}
