import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  final Function(File file) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: _getFromCamera,
              child: const Text(
                'Câmera',
              ),
            ),
            TextButton(
              onPressed: _getFromGallery,
              child: const Text(
                'Galeria',
              ),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o anúncio'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: _getFromCamera,
            child: const Text(
              'Câmera',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: _getFromGallery,
            child: const Text(
              'Galeria',
            ),
          ),
        ],
      );
    }
  }

  Future<void> _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    imageSelected(pickedFile);
  }

  Future<void> _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    imageSelected(pickedFile);
  }

  Future<void> imageSelected(XFile? pickedFile) async {
    if (pickedFile == null) {
      return;
    }

    final image = File(pickedFile.path);

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );

    if (croppedImage != null) {
      onImageSelected(croppedImage);
    }
  }
}
