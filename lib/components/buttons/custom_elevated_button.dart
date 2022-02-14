import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.buttonChild,
    required this.onPressed,
  }) : super(key: key);

  final Widget buttonChild;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: buttonChild,
      ),
    );
  }
}
