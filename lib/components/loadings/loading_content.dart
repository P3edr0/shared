import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key, this.value});
  final double? value;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: Responsive.getSize(200),
      width: size.width,
      decoration: const BoxDecoration(color: primaryFocusColor),
      child: Center(
        child: SizedBox(
          width: Responsive.getSize(50),
          height: Responsive.getSize(50),
          child: CircularProgressIndicator(
            color: secondaryColor,
            strokeWidth: 6,
            value: value,
          ),
        ),
      ),
    );
  }
}
