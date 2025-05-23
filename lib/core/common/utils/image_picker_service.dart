import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the camera.
  Future<File?> pickFromCamera() async {
    return _pickImage(ImageSource.camera);
  }

  /// Picks an image from the gallery.
  Future<File?> pickFromGallery() async {
    return _pickImage(ImageSource.gallery);
  }

  /// Internal function to handle image picking logic.
  Future<File?> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      // Handle errors here (e.g., permissions)
      print('Image picking error: $e');
      return null;
    }
  }
}
