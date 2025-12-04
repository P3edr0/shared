import 'package:flutter/material.dart';
import 'package:shared/theme/colors.dart';

import '../../responsiveness/responsive.dart';

class SharedScreenLoading extends StatelessWidget {
  const SharedScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: primaryColor,
              child: SizedBox.square(
                dimension: Responsive.getSize(60),
                child: CircularProgressIndicator(
                  color: secondaryColor,
                  strokeWidth: 6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
