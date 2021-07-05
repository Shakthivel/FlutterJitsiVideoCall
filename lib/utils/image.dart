import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_clone/constants/colors.dart';

final _picker = ImagePicker();

Future<File> selectImage() async {
  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  File croppedFile = await ImageCropper.cropImage(
    sourcePath: pickedFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 60,
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Profile Picture',
      toolbarColor: appPurple,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.square,
      lockAspectRatio: false,
    ),
  );
  return croppedFile;
}
