import 'dart:async';

import 'package:video_player/video_player.dart';

import 'video_player_service.dart';

class VideoPlayerServiceImpl implements IVideoPlayerService {
  VideoPlayerController? _controller;
  final _isPlayingController = StreamController<bool>.broadcast();
  final _isLoadingController = StreamController<bool>.broadcast();
  final _isInitializedController = StreamController<bool>.broadcast();

  bool _isDisposed = false;

  @override
  VideoPlayerController? get controller => _controller;

  @override
  Stream<bool> get isPlayingStream => _isPlayingController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  @override
  Stream<bool> get isInitializedStream => _isInitializedController.stream;

  @override
  Future<void> initialize(String videoUrl) async {
    if (_isDisposed) throw Exception('VideoService já foi descartado');

    _isLoadingController.add(true);

    try {
      await _controller?.dispose();

      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..setLooping(true);

      _controller?.addListener(_updatePlayingState);

      await _controller?.initialize();

      _isInitializedController.add(true);
      _isLoadingController.add(false);
    } catch (e) {
      _isLoadingController.add(false);
      _isInitializedController.add(false);
      rethrow;
    }
  }

  @override
  void play() {
    if (_controller?.value.isInitialized == true) {
      _controller?.play();
    }
  }

  @override
  void pause() {
    if (_controller?.value.isInitialized == true) {
      _controller?.pause();
    }
  }

  @override
  void togglePlayPause() {
    if (_controller?.value.isPlaying == true) {
      pause();
    } else {
      play();
    }
  }

  void _updatePlayingState() {
    if (!_isDisposed && _controller != null) {
      _isPlayingController.add(_controller!.value.isPlaying);
    }
  }

  @override
  void dispose() {
    if (!_isDisposed) {
      _isDisposed = true;
      _controller?.dispose();
      _controller = null;
      _isPlayingController.close();
      _isLoadingController.close();
      _isInitializedController.close();
    }
  }
}
