import 'dart:io';

abstract class IMediaPickerService {
  Future<File?> recordVideo();
  Future<File?> pickFromGallery();
  Future<File?> takePhoto();
}
