import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared/components/post_owner_details.dart';
import 'package:shared/presenter/post_details_page/store/post_details_store.dart';
import 'package:shared/presenter/post_page/store/components/post_preview.dart';
import 'package:shared/presenter/post_page/store/post_store.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/theme/colors.dart';
import 'package:shared/utils/formatters/date_formatter.dart';
import 'package:shared/utils/routes/app_routes.dart';

import '../../components/app_bars/app_bar.dart';
import '../../responsiveness/shared_font_style.dart';
import '../../utils/dependencies.dart';
import '../../utils/enums/page_type.dart';
import '../../utils/routes/app_navigator.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({super.key});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final store = getIt<PostDetailsStore>();
  final _navigator = AppNavigator();
  @override
  Widget build(BuildContext context) {
    final selectedPost = store.selectedPost!;
    final postOwner = store.getUser('1');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Responsive.getSize(20)),
            SharedAppBar(label: 'Detalhes do post'),
            SizedBox(height: Responsive.getSize(16)),
            Container(
              margin: EdgeInsets.all(Responsive.getSize(16)),

              padding: EdgeInsets.all(Responsive.getSize(16)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor, width: 2),
              ),

              child: Column(
                children: [
                  Text(
                    selectedPost.subtitle,
                    style: SharedFontStyle.body.copyWith(color: primaryColor),
                  ),
                  SizedBox(height: Responsive.getSize(4)),

                  Observer(
                    builder: (context) {
                      return PostPreview.imageNetwork(
                        url: selectedPost.contentUrl,
                      );
                    },
                  ),

                  SizedBox(height: Responsive.getSize(20)),

                  Container(
                    padding: EdgeInsets.all(Responsive.getSize(16)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SharedPostOwnerDetails(
                          postDate: '',
                          userImage: postOwner.image,
                          userName: postOwner.name,
                          onEditTap: () {
                            final postStore = getIt<PostStore>();
                            postStore.setPageType(PageType.edit, selectedPost);
                            _navigator.goto(SharedRoutes.post);
                          },
                        ),
                        SizedBox(height: Responsive.getSize(16)),
                        Text(
                          'Nome do arquivo: ${store.getFileName() ?? ''}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        Text(
                          'Id da postagem: ${selectedPost.id}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        SelectableText(
                          'Link da imagem: ${selectedPost.contentUrl}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        Text(
                          'Data da postagem: ${SharedDateFormatter.toDayMonthYear(selectedPost.date)}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        Text(
                          'Tipo de postagem: ${selectedPost.type.toString()}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),

                        Text(
                          'N° de curtidas: ${selectedPost.likes}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        Text(
                          'N° de comentários: ${selectedPost.comments.length}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                        Text(
                          'N° de compartilhamentos: ${selectedPost.shares}',
                          style: SharedFontStyle.body.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                        Divider(color: secondaryColor.withValues(alpha: 0.2)),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.getSize(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
