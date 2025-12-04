import 'package:flutter/material.dart';
import 'package:shared/components/button/main_button.dart';
import 'package:shared/theme/colors.dart';

import '../../responsiveness/shared_font_style.dart';

class InfoDialog {
  const InfoDialog();

  static Future show(String title, String content, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: SharedFontStyle.bodyLargeBold,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: SharedFontStyle.body,
          textAlign: TextAlign.center,
        ),
        actions: [
          SharedMainButton(
            onTap: () => Navigator.of(context).pop(),

            label: Text(
              'Voltar',
              style: SharedFontStyle.bodyLargeBold.copyWith(
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future closeAuto(
    String title,
    String content,
    BuildContext context,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        });
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content, textAlign: TextAlign.center),
        );
      },
    );
  }
}
