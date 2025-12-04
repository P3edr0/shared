import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../responsiveness/shared_font_style.dart';
import '../../theme/colors.dart';

class InteractionButton extends StatelessWidget {
  const InteractionButton({
    super.key,
    required this.content,
    required this.icon,
    required this.onTap,
    required this.taped,
  });
  final IconData icon;
  final String content;
  final VoidCallback onTap;
  final bool taped;

  @override
  Widget build(BuildContext context) {
    final color = taped ? primaryColor : secondaryFocusColor;
    final fontStyle = taped ? SharedFontStyle.smallBold : SharedFontStyle.small;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.getSize(4),
          horizontal: Responsive.getSize(8),
        ),
        decoration: BoxDecoration(
          color: secondaryColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: Responsive.getSize(16), color: color),
            SizedBox(width: Responsive.getSize(6)),

            Text(content, style: fontStyle.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
