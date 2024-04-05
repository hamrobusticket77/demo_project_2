import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static final _picker = ImagePicker();

  static Future<File?> getCamera({bool showOnlyFrontCamera = false}) async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice:
            showOnlyFrontCamera ? CameraDevice.front : CameraDevice.rear);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<File?> getGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
