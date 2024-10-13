import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController textController,
    required String hintText,
    double? height = 30,
  })  : _textController = textController,
        _hintText = hintText,
        _height = height;

  final TextEditingController _textController;
  final String _hintText;
  final double? _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: 250,
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          border: const OutlineInputBorder(),
          hintText: _hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        maxLines: null,
      ),
    );
  }
}
