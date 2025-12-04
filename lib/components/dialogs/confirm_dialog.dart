import 'package:flutter/material.dart';
import 'package:shared/components/button/main_button.dart';

import '../../responsiveness/shared_font_style.dart';
import '../../theme/colors.dart';

class ConfirmDialog {
  const ConfirmDialog();

  static Future<bool?> show(
    String title,
    String content,
    BuildContext context,
    VoidCallback confirmCallback,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          SharedMainButton(
            buttonColor: secondaryColor,
            onTap: () => Navigator.of(context).pop(),
            label: Text(
              'Voltar',
              style: SharedFontStyle.bodyLargeBold.copyWith(
                color: secondaryFocusColor,
              ),
            ),
          ),
          SharedMainButton(
            onTap: confirmCallback,
            label: Text(
              'Confirmar',
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
        Future.delayed(Durations.extralong4, () {
          if (context.mounted) {
            Navigator.of(context).pop(false);
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
