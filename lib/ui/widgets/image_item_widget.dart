import 'dart:io';

import 'package:authorised_image_picker/models/base_image_model.dart';
import 'package:flutter/material.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({super.key, required this.details});

  final BaseImageModel details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (BuildContext context) {
            return Dialog.fullscreen(
              child: details.id != null
                  ? Image.network(details.downloadUrl, fit: BoxFit.contain)
                  : Image.file(File(details.url), fit: BoxFit.contain),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(details.author),
            Text(details.id ?? '', style: TextStyle(color: Colors.blueGrey)),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: details.id != null
                    ? Image.network(details.downloadUrl, fit: BoxFit.fill)
                    : Image.file(File(details.url), fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
