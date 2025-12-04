// lib/core/services/video_service/ivideo_service.dart
import 'package:video_player/video_player.dart';

abstract class IVideoPlayerService {
  Future<void> initialize(String videoUrl);

  void play();

  void pause();

  void togglePlayPause();

  void dispose();

  VideoPlayerController? get controller;

  Stream<bool> get isPlayingStream;

  Stream<bool> get isLoadingStream;

  Stream<bool> get isInitializedStream;
}
