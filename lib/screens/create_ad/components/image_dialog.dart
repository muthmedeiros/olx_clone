import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({
    Key? key,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          TextButton(
            child: const Text('Excluir'),
            style: TextButton.styleFrom(primary: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
