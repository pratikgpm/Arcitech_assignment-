import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/core/widgets/customButton.dart';
import 'package:arcitech/core/widgets/customField.dart';
import 'package:arcitech/features/controller/userController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.read(userProvider.notifier);
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Pallete.formFieldGrey,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL.toString())
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Pallete.bgBlue,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Pallete.whiteColor),
                          onPressed: () {
                            // Your function here
                            userNotifier.pickAndUploadImage();
                          },
                          iconSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Your Name",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallete.regFontColr),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFields.CustomFields(
              controller: nameController,
            ),
            const SizedBox(
              height: 50,
            ),
            customButton(
              title: "Update",
              onPressed: () {
                userNotifier.updateUserProfile(nameController.text);
                nameController.clear();
              },
            )
          ],
        ),
      )),
    );
    ;
  }
}
