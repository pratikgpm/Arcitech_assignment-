import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

class CustomFields extends StatefulWidget {
  final bool isPassword;
  final TextEditingController? controller;

  const CustomFields.CustomFields({
    super.key,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomFields> createState() => _SpotifyCustomFieldsState();
}

class _SpotifyCustomFieldsState extends State<CustomFields> {
  bool _visiblePassword = true;

  void togglePasswordVisiblity() {
    _visiblePassword = !_visiblePassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          color: Pallete.headingFontColr,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      obscureText: widget.isPassword ? _visiblePassword : false,
      cursorColor: Pallete.headingFontColr,
      keyboardType: TextInputType.emailAddress,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: togglePasswordVisiblity,
                icon: Icon(
                  !_visiblePassword ? Icons.visibility : Icons.visibility_off,
                  color: Pallete.headingFontColr,
                ))
            : null,
        contentPadding:
            EdgeInsets.only(left: 20, top: 17, bottom: 12, right: 10),
        fillColor: Pallete.whiteColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Pallete.formFieldGrey),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Pallete.formFieldGrey),
            borderRadius: BorderRadius.circular(15)),
        errorStyle: TextStyle(color: Pallete.regFontColr),
      ),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "can't be empty";
        }
        return null;
      },
    );
  }
}
