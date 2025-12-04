import 'package:flutter/material.dart';
import 'package:shared/theme/colors.dart';

import '../../responsiveness/responsive.dart';

class SharedSmallLoading extends StatelessWidget {
  const SharedSmallLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Responsive.getSize(22),
      child: CircularProgressIndicator(color: secondaryColor),
    );
  }
}
