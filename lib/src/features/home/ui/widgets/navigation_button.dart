
import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    required this.screen,
    required this.buttonTitle,
    super.key,
  });

  final Widget screen;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => screen,
        ),
      ),
      child: Text(buttonTitle),
    );
  }
}
