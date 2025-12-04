import 'package:flutter/material.dart';
import 'package:shared/components/cards/video_player.dart';
import 'package:shared/services/video_player/video_player_service.dart';
import 'package:shared/utils/icons.dart';

import '../../responsiveness/responsive.dart';
import '../../responsiveness/shared_font_style.dart';
import '../../theme/colors.dart';
import '../button/interaction_button.dart';
import '../post_interactions_bar.dart';
import '../post_owner_details.dart';

class SharedVideoPost extends StatelessWidget {
  const SharedVideoPost({
    super.key,
    required this.userImage,
    required this.postDate,
    required this.userName,
    required this.postVideo,
    required this.subtitle,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.onEditTap,
    required this.onPostTap,
    required this.videoPlayerService,
  });

  final String postDate;
  final String userImage;
  final String userName;
  final String postVideo;
  final String subtitle;
  final int likes;
  final int comments;
  final int shares;
  final VoidCallback onEditTap;
  final VoidCallback onPostTap;
  final IVideoPlayerService videoPlayerService;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPostTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSize(16),
              vertical: Responsive.getSize(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SharedPostOwnerDetails(
                  postDate: postDate,
                  userImage: userImage,
                  userName: userName,
                  onEditTap: onEditTap,
                ),
                SizedBox(height: Responsive.getSize(8)),
                Text(
                  subtitle,
                  style: SharedFontStyle.body.copyWith(color: secondaryColor),
                ),
                SizedBox(height: Responsive.getSize(8)),

                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    height: Responsive.getSize(300),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SharedVideoPlayer(
                      videoUrl: postVideo,
                      videoService: videoPlayerService,
                    ),
                    //  Image.network(
                    //   postImage,
                    //   fit: BoxFit.cover,
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     final value = loadingProgress.expectedTotalBytes != null
                    //         ? loadingProgress.cumulativeBytesLoaded /
                    //               loadingProgress.expectedTotalBytes!
                    //         : null;
                    //     return LoadingContent(value: value);
                    //   },
                    //   errorBuilder: (context, error, stackTrace) => SizedBox(
                    //     height: Responsive.getSize(150),
                    //     width: double.infinity,
                    //   ),
                    // ),
                  ),
                ),

                SizedBox(height: Responsive.getSize(8)),
                SharedPostInteractionsBar(
                  interactionsItems: [
                    InteractionButton(
                      icon: SharedIcons.like,
                      onTap: () {},
                      content: likes.toString(),
                      taped: true,
                    ),
                    InteractionButton(
                      icon: SharedIcons.comment,
                      onTap: () {},
                      content: comments.toString(),
                      taped: false,
                    ),
                    InteractionButton(
                      icon: SharedIcons.share,
                      onTap: () {},
                      content: shares.toString(),
                      taped: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: secondaryColor, height: 2),
        ],
      ),
    );
  }
}
