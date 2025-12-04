import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'media_picker_service.dart';

class MediaPickerServiceImpl extends IMediaPickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  @override
  Future<File?> pickFromGallery() async {
    final XFile? media = await _picker.pickMedia(
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (media != null) {
      final List<String> allowedExtensions = [
        '.jpg',
        '.jpeg',
        '.png',
        '.gif',
        '.mp4',
        '.mov',
        '.mkv',
        '.webm',
      ];

      final extension = media.path.toLowerCase().split('.').last;
      final isValid = allowedExtensions.any((ext) => ext.endsWith(extension));
      if (isValid) {
        return File(media.path);
      }
    }
    return null;
  }

  @override
  Future<File?> recordVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 60),
    );

    if (video != null) {
      return File(video.path);
    }
    return null;
  }
}
