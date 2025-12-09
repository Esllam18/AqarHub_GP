import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/services.dart';

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 512,
    maxHeight: 512,
    imageQuality: 80,
  );
  if (pickedFile != null) {
    HapticFeedback.lightImpact();
    return File(pickedFile.path);
  }
  return null;
}
