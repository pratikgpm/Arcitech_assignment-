import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/features/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 183,
          color: Pallete.bgBlue,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hey ${user?.displayName ?? 'user'}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Pallete.whiteColor,
                  fontSize: 24, // You can adjust the size if needed
                ),
              ),
              CircleAvatar(
                backgroundColor: Pallete.whiteColor,
                radius: 44,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
              )
            ],
          ),
        ),
      ],
    ));
    ;
  }
}
