import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;
  final VoidCallback? onSearchBarHit;

  const CustomSearchField({
    Key? key,
    this.hintText = "find course",
    this.onChanged,
    this.onFilterPressed,
    this.onSearchBarHit,
  }) : super(key: key);

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  TextEditingController _controller = TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onSearchBarHit,
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Pallete.formFieldGrey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        hintStyle: const TextStyle(
            color: Pallete.formFieldGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        hintText: widget.hintText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_showClearIcon)
              IconButton(
                icon: SvgPicture.asset('assets/svg_files/clearCut.svg'),
                onPressed: () {
                  _controller.clear();
                },
              ),
            IconButton(
              icon: SvgPicture.asset('assets/svg_files/filter.svg'),
              onPressed: widget.onFilterPressed,
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Pallete.circularProgressSecondary,
      ),
    );
  }
}
