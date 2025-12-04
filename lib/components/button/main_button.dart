import 'package:flutter/material.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/theme/colors.dart';

class SharedMainButton extends StatelessWidget {
  const SharedMainButton({
    super.key,
    required this.onTap,
    this.buttonColor = primaryColor,
    required this.label,
    this.haveBorder = false,
    this.pad = 10,
    this.height = 48,
    this.width,
  });
  final VoidCallback? onTap;
  final Widget label;
  final double? width;
  final Color buttonColor;
  final bool haveBorder;
  final double pad;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double handledPad = Responsive.getSize(pad);
    return InkWell(
      onTap: () async {
        if (onTap != null) {
          onTap!.call();
        }
      },
      child: Container(
        width: width,
        height: height != null ? Responsive.getSize(height!) : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: haveBorder ? Border.all(width: 1, color: Colors.grey) : null,
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: handledPad),
          child: label,
        ),
      ),
    );
  }
}
