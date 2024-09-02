import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPge extends StatelessWidget {
  final String ImagePath;
  const PhotoPge({super.key, required this.ImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: FileImage(File(ImagePath)),
       
      ),
    );
  }
}
