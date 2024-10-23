// will be created later
import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomToggleButtons extends StatefulWidget {
  final List<String> buttonLabels;
  final ValueChanged<int> onToggle;

  CustomToggleButtons({required this.buttonLabels, required this.onToggle});

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedIndex = 0; // Initialize to -1 for no selection

  Widget buildToggleButton(String text, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
          widget.onToggle(index); // Call the provided toggle function
        });
      },
      child: Container(
        width: 73,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isSelected ? Pallete.whiteColor : Pallete.regFontColr,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.buttonLabels.length, (index) {
        return buildToggleButton(widget.buttonLabels[index], index);
      }),
    );
  }
}
