import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';
import '../../utils/icons.dart';

class SharedPlayPauseButton extends StatelessWidget {
  const SharedPlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.togglePlayPause,
  });
  final VoidCallback togglePlayPause;
  final bool isPlaying;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      right: 12,
      child: InkWell(
        onTap: togglePlayPause,
        child: Container(
          padding: EdgeInsets.all(Responsive.getSize(6)),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPlaying ? SharedIcons.play : SharedIcons.pause,
            size: Responsive.getSize(24),
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
