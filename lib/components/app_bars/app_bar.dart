import 'package:flutter/material.dart';
import 'package:shared/responsiveness/shared_font_style.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';
import '../../utils/icons.dart';

class SharedAppBar extends StatelessWidget {
  const SharedAppBar({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: secondaryFocusColor.withValues(alpha: 0.2),
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(Responsive.getSize(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          canPop
              ? InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(SharedIcons.back, size: Responsive.getSize(32)),
                )
              : SizedBox.shrink(),
          Text(label, style: SharedFontStyle.titleBold),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
