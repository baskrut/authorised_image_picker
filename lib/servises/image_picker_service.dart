import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

final class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickGalleryImage() async {
    try {
      return await _imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      return null;
    }
  }
}
