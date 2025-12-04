import 'dart:io';

abstract class IImagePickerService {
  Future<File?> recordVideo();
  Future<File?> pickFromGallery();
  Future<File?> takePhoto();
}
