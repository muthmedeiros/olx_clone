import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../stores/create_ad_store.dart';
import 'image_dialog.dart';
import 'image_source_modal.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({
    Key? key,
    required this.createAdStore,
  }) : super(key: key);

  final CreateAdStore createAdStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createAdStore.images.add(image);

      Navigator.of(context).pop();
    }

    return Container(
      height: 150,
      color: Colors.grey[200],
      child: Observer(builder: (context) {
        return ListView.builder(
          itemCount: createAdStore.itemCountLimit,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            if (index == createAdStore.images.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid) {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => ImageSourceModal(
                          onImageSelected: onImageSelected,
                        ),
                      );
                    } else {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => ImageSourceModal(
                          onImageSelected: onImageSelected,
                        ),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => ImageDialog(
                      image: createAdStore.images[index],
                      onDelete: () => createAdStore.images.removeAt(index),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: FileImage(createAdStore.images[index]),
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
