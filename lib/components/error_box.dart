import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Oops! $message. Por favor, tente novamente!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
