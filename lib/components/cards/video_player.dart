// lib/ui/widgets/video_card_player.dart
import 'package:flutter/material.dart';
import 'package:shared/components/button/main_button.dart';
import 'package:shared/components/button/play_pause_button.dart';
import 'package:shared/services/video_player/video_player_service.dart'
    show IVideoPlayerService;
import 'package:shared/theme/colors.dart';
import 'package:video_player/video_player.dart';

import '../../components/loadings/loading_content.dart';
import '../../responsiveness/responsive.dart';
import '../../responsiveness/shared_font_style.dart';

class SharedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final IVideoPlayerService videoService;
  final bool autoPlay;
  final bool showControls;

  const SharedVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.videoService,
    this.autoPlay = true,
    this.showControls = true,
  });

  @override
  State<SharedVideoPlayer> createState() => _SharedVideoPlayerState();
}

class _SharedVideoPlayerState extends State<SharedVideoPlayer> {
  late IVideoPlayerService _videoService;
  bool _isPlaying = false;
  bool _isLoading = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoService = widget.videoService;
    _initializeVideo();
    _setupListeners();
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoService.initialize(widget.videoUrl);

      if (widget.autoPlay && mounted) {
        _videoService.play();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _setupListeners() {
    _videoService.isPlayingStream.listen((isPlaying) {
      if (mounted) {
        setState(() => _isPlaying = isPlaying);
      }
    });

    _videoService.isLoadingStream.listen((isLoading) {
      if (mounted) {
        setState(() => _isLoading = isLoading);
      }
    });

    _videoService.isInitializedStream.listen((initialized) {
      if (mounted) {
        setState(() => _isInitialized = initialized);
      }
    });
  }

  void _togglePlayPause() {
    _videoService.togglePlayPause();
  }

  @override
  void didUpdateWidget(SharedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl && mounted) {
      _initializeVideo();
    }
  }

  @override
  void dispose() {
    _videoService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_isInitialized && _videoService.controller != null)
            VideoPlayer(_videoService.controller!)
          else if (_isLoading)
            const SharedLoadingContent(value: null)
          else
            _buildErrorWidget(),

          if (_isInitialized && widget.showControls && !_isLoading)
            SharedPlayPauseButton(
              isPlaying: _isPlaying,
              togglePlayPause: _togglePlayPause,
            ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: secondaryFocusColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: primaryColor, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Erro ao carregar vídeo',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            SharedMainButton(
              width: Responsive.getSize(200),
              onTap: _initializeVideo,
              label: Text(
                'Tentar novamente',
                style: SharedFontStyle.bodyBold.copyWith(color: secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
