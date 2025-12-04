import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared/components/button/main_button.dart';
import 'package:shared/components/textfield/textfield.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/presenter/post_page/store/components/post_preview.dart';
import 'package:shared/presenter/post_page/store/post_store.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/theme/colors.dart';
import 'package:shared/utils/enums/post_type.dart';
import 'package:shared/utils/icons.dart';

import '../../components/app_bars/app_bar.dart';
import '../../components/loadings/small_loading.dart';
import '../../responsiveness/shared_font_style.dart';
import '../../services/image_picker/image_picker_service.dart';
import '../../utils/dependencies.dart';
import '../../utils/routes/app_navigator.dart';
import '../../utils/routes/app_routes.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _pickerService = getIt<IImagePickerService>();
  final _store = getIt<PostStore>();
  final _navigator = AppNavigator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Responsive.getSize(20)),
            Observer(
              builder: (context) {
                return SharedAppBar(
                  label: _store.pageType.isCreate
                      ? 'Adicionar novo post'
                      : 'Editar publicação',
                );
              },
            ),
            SizedBox(height: Responsive.getSize(20)),
            Padding(
              padding: EdgeInsets.all(Responsive.getSize(16)),
              child: Column(
                children: [
                  Observer(
                    builder: (context) {
                      return PostPreview(
                        image: _store.selectedImage,
                        video: _store.selectedVideo,
                        url: _store.selectedToEditPost?.contentUrl,
                      );
                    },
                  ),

                  Text(
                    _store.getFileName() ?? '',
                    style: SharedFontStyle.body.copyWith(color: primaryColor),
                  ),
                  SizedBox(height: Responsive.getSize(30)),
                  SharedTextfield(
                    controller: _store.subtitleController,
                    maxLines: 3,
                    hint: 'Descreva sua publicação...',
                  ),

                  SizedBox(height: Responsive.getSize(30)),

                  Row(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return SharedMainButton(
                              onTap: () async {
                                final image = await _pickerService.takePhoto();
                                if (image != null) {
                                  _store.setSelectedImage(image);
                                  _store.setSelectedVideo(null);
                                }
                              },

                              label: Row(
                                children: [
                                  Icon(
                                    SharedIcons.pickPhoto,
                                    size: Responsive.getSize(32),
                                  ),
                                  SizedBox(width: Responsive.getSize(16)),
                                  Text(
                                    'Tirar foto',
                                    style: SharedFontStyle.bodyBold,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: Responsive.getSize(16)),

                      Expanded(
                        child: SharedMainButton(
                          onTap: () async {
                            final media = await _pickerService
                                .pickFromGallery();
                            if (media != null) {
                              final List<String> imageExtensions = [
                                '.jpg',
                                '.jpeg',
                                '.png',
                                '.gif',
                              ];
                              final extension = media.path
                                  .toLowerCase()
                                  .split('.')
                                  .last;
                              final isImage = imageExtensions.any(
                                (ext) => ext.endsWith(extension),
                              );

                              if (isImage) {
                                _store.setSelectedImage(media);
                                _store.setSelectedVideo(null);
                                return;
                              }
                              _store.setSelectedImage(null);
                              _store.setSelectedVideo(media);
                            }
                          },

                          label: Row(
                            children: [
                              Icon(
                                SharedIcons.gallery,
                                size: Responsive.getSize(32),
                              ),
                              SizedBox(width: Responsive.getSize(16)),
                              Text('Galeria', style: SharedFontStyle.bodyBold),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.getSize(16)),

                  Row(
                    children: [
                      Expanded(
                        child: SharedMainButton(
                          onTap: () async {
                            final video = await _pickerService.recordVideo();
                            if (video != null) {
                              setState(() {
                                _store.setSelectedImage(null);
                                _store.setSelectedVideo(video);
                              });
                            }
                          },
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                SharedIcons.videoRecord,
                                size: Responsive.getSize(32),
                              ),
                              SizedBox(width: Responsive.getSize(16)),
                              Text(
                                'Gravar vídeo',
                                style: SharedFontStyle.bodyBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Responsive.getSize(30)),
                  if (_store.pageType.isCreate)
                    Row(
                      children: [
                        Expanded(
                          child: Observer(
                            builder: (context) {
                              return SharedMainButton(
                                onTap: () async {
                                  if (_store.isLoading) return;

                                  final subtitle =
                                      _store.subtitleController.text;
                                  final newPost = PostEntity(
                                    id: UniqueKey().toString(),
                                    type: PostType.image,
                                    subtitle: subtitle,
                                    userId: '1',
                                    date: DateTime.now(),
                                    localContent: _store.selectedImage,
                                    likes: 0,
                                    comments: [],
                                    shares: 0,
                                  );
                                  final response = await _store.createPost(
                                    newPost,
                                  );
                                  if (response) {
                                    _navigator.goto(
                                      SharedRoutes.home,
                                      clearStack: true,
                                    );
                                  }
                                },
                                label: _store.isLoading
                                    ? SharedSmallLoading()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            SharedIcons.videoRecord,
                                            size: Responsive.getSize(32),
                                            color: secondaryColor,
                                          ),
                                          SizedBox(
                                            width: Responsive.getSize(16),
                                          ),
                                          Text(
                                            'Publicar',
                                            style: SharedFontStyle.bodyLargeBold
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  if (_store.pageType.isEdit)
                    Row(
                      children: [
                        Expanded(
                          child: Observer(
                            builder: (context) {
                              return SharedMainButton(
                                onTap: () async {
                                  if (_store.isLoading) return;
                                  final subtitle =
                                      _store.subtitleController.text;
                                  final updatedPost = _store.selectedToEditPost!
                                      .copyWith(
                                        type: PostType.image,
                                        subtitle: subtitle,
                                        localContent: _store.selectedImage,
                                      );
                                  final response = await _store.updatePost(
                                    updatedPost,
                                  );
                                  if (response) {
                                    _navigator.goto(
                                      SharedRoutes.home,
                                      clearStack: true,
                                    );
                                  }
                                },
                                label: _store.isLoading
                                    ? SharedSmallLoading()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            SharedIcons.update,
                                            size: Responsive.getSize(24),
                                            color: secondaryColor,
                                          ),
                                          SizedBox(
                                            width: Responsive.getSize(16),
                                          ),
                                          Text(
                                            'Atualizar',
                                            style: SharedFontStyle.bodyLargeBold
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: Responsive.getSize(16)),
                        Expanded(
                          child: Observer(
                            builder: (context) {
                              return SharedMainButton(
                                buttonColor: Colors.red,
                                onTap: () async {
                                  if (_store.isLoading) return;

                                  final subtitle =
                                      _store.subtitleController.text;
                                  final toDeletePost = _store
                                      .selectedToEditPost!
                                      .copyWith(
                                        type: PostType.image,
                                        subtitle: subtitle,
                                        localContent: _store.selectedImage,
                                      );
                                  final response = await _store.deletePost(
                                    toDeletePost,
                                  );
                                  if (response) {
                                    _navigator.goto(
                                      SharedRoutes.home,
                                      clearStack: true,
                                    );
                                  }
                                },
                                label: _store.isLoading
                                    ? SharedSmallLoading()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            SharedIcons.delete,
                                            size: Responsive.getSize(24),
                                            color: secondaryColor,
                                          ),
                                          SizedBox(
                                            width: Responsive.getSize(16),
                                          ),
                                          Text(
                                            'Deletar',
                                            style: SharedFontStyle.bodyLargeBold
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: Responsive.getSize(40)),
          ],
        ),
      ),
    );
  }
}
