import 'package:flutter/material.dart';
import 'package:shared/utils/icons.dart';

import '../responsiveness/responsive.dart';
import '../responsiveness/shared_font_style.dart';
import '../theme/colors.dart';
import 'circle_avatar.dart';

class SharedPostOwnerDetails extends StatelessWidget {
  const SharedPostOwnerDetails({
    super.key,
    required this.postDate,
    required this.userImage,
    required this.userName,
    required this.onEditTap,
  });
  final String userImage;
  final String userName;
  final String postDate;
  final VoidCallback onEditTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AccCircleAvatar(
          backgroundColor: secondaryColor,
          picture: userImage,
          size: Responsive.getSize(26),
          onTap: () {},
        ),
        SizedBox(width: Responsive.getSize(8)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: SharedFontStyle.bodyLargeBold.copyWith(
                color: secondaryColor,
              ),
            ),
            Text(
              postDate,
              style: SharedFontStyle.small.copyWith(color: secondaryColor),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: onEditTap,
          child: Icon(SharedIcons.edit, color: secondaryColor),
        ),
      ],
    );
  }
}
