import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

class customButton extends StatelessWidget {
  final bool isInverse;
  final String title;
  final VoidCallback onPressed;

  const customButton({
    super.key,
    this.isInverse = false,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: isInverse ? Pallete.bgBlue : Pallete.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isInverse ? Pallete.whiteColor : Pallete.bgBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isInverse
                ? const BorderSide(width: 0.5, color: Pallete.bgBlue)
                : const BorderSide(width: 0.0),
          ),
        ),
      ),
    );
  }
}
