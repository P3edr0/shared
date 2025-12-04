import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/responsiveness/shared_font_style.dart';

import '../../../../theme/colors.dart';
import '../../../../utils/icons.dart';

class PostPreview extends StatelessWidget {
  const PostPreview({
    super.key,
    required this.image,
    required this.video,
    required this.url,
  });
  const PostPreview.imageNetwork({super.key, required this.url})
    : image = null,
      video = null;
  final File? image;
  final File? video;
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Container(
        height: Responsive.getSize(300),
        width: Responsive.getSize(200),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(image!, fit: BoxFit.cover),
        ),
      );
    } else if (video != null) {
      return Container(
        height: Responsive.getSize(300),
        width: Responsive.getSize(200),

        decoration: BoxDecoration(
          color: secondaryFocusColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                SharedIcons.film,
                size: Responsive.getSize(40),
                color: secondaryColor,
              ),
              SizedBox(height: Responsive.getSize(10)),
              Text(
                'Vídeo selecionado',
                style: SharedFontStyle.smallBold.copyWith(
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (url != null) {
      return Container(
        height: Responsive.getSize(300),
        width: Responsive.getSize(200),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(url!, fit: BoxFit.cover),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(Responsive.getSize(16)),
      height: Responsive.getSize(300),
      width: Responsive.getSize(200),
      decoration: BoxDecoration(
        color: primaryFocusColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryFocusColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: Responsive.getSize(60), color: primaryColor),
          SizedBox(height: Responsive.getSize(10)),
          Text(
            'Nenhuma imagem ou vídeo selecionado.',
            style: SharedFontStyle.smallBold.copyWith(color: primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
