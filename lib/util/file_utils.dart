import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  Utils._();

  /// Open image gallery and pick an image
  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  /// Pick Image From Gallery and return a File
  // static Future<File?> cropSelectedImage(String filePath) async {
  //   return await ImageCropper.cropImage(
  //     sourcePath: filePath,
  //     aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //     iosUiSettings: const IOSUiSettings(
  //       title: 'Crop Image',
  //       aspectRatioLockEnabled: true,
  //       minimumAspectRatio: 1.0,
  //       aspectRatioPickerButtonHidden: true,
  //     ),
  //   );
  // }

  static Future<File?> cropSelectedImage(String filePath) async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        // WebUiSettings(
        //   context: context,
        // ),
      ],
    );
    return File(croppedFile?.path??"");
  }

}