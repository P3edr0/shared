import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared/presenter/home/store/home_store.dart';
import 'package:shared/presenter/post_details_page/store/post_details_store.dart';
import 'package:shared/presenter/post_page/store/post_store.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/responsiveness/shared_font_style.dart';
import 'package:shared/services/video_player/video_player_service.dart';
import 'package:shared/theme/colors.dart';
import 'package:shared/utils/dependencies.dart';
import 'package:shared/utils/formatters/date_formatter.dart';

import '../../components/app_bars/app_bar.dart';
import '../../components/cards/image_post.dart';
import '../../components/cards/video_post .dart';
import '../../components/loadings/screen_loading.dart';
import '../../utils/enums/page_type.dart';
import '../../utils/routes/app_navigator.dart';
import '../../utils/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = getIt<HomeStore>();
  final _postStore = getIt<PostStore>();
  final _videoService = getIt<IVideoPlayerService>();
  final _navigator = AppNavigator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _store.fetchAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Observer(
        builder: (context) {
          return _store.isLoading
              ? SharedScreenLoading()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: Responsive.getSize(20)),
                      SharedAppBar(label: 'Feed'),
                      SizedBox(height: Responsive.getSize(20)),

                      InkWell(
                        onTap: () {
                          _postStore.setPageType(PageType.create, null);

                          _navigator.goto(SharedRoutes.post);
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,

                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.all(Responsive.getSize(8)),
                          margin: EdgeInsets.symmetric(
                            horizontal: Responsive.getSize(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: Responsive.getSize(32),
                              ),
                              SizedBox(width: Responsive.getSize(16)),
                              Text(
                                'Criar novo post...',
                                style: SharedFontStyle.bodyLargeBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.getSize(16)),

                      Observer(
                        builder: (context) {
                          return Column(
                            children: _store.posts.map((post) {
                              final user = _store.getUser(post.userId);

                              if (!post.type.isImage) {
                                return SharedVideoPost(
                                  videoPlayerService: _videoService,
                                  userImage: user.image,
                                  postDate: SharedDateFormatter().dateResume(
                                    post.date,
                                  ),
                                  userName: user.name,
                                  postVideo: post.contentUrl!,
                                  subtitle: post.subtitle,
                                  likes: post.likes,
                                  comments: post.comments.length,
                                  shares: post.shares,
                                  onEditTap: () {
                                    _postStore.setPageType(PageType.edit, post);
                                    _navigator.goto(SharedRoutes.post);
                                  },
                                  onPostTap: () {
                                    final postDetailsStore =
                                        getIt<PostDetailsStore>();
                                    postDetailsStore.setSelectedPost(post);
                                    _navigator.goto(SharedRoutes.postDetails);
                                  },
                                );
                              }

                              return SharedImagePost(
                                userImage: user.image,
                                postDate: SharedDateFormatter().dateResume(
                                  post.date,
                                ),
                                userName: user.name,
                                postImage: post.contentUrl!,
                                subtitle: post.subtitle,
                                likes: post.likes,
                                comments: post.comments.length,
                                shares: post.shares,
                                onEditTap: () {
                                  _postStore.setPageType(PageType.edit, post);
                                  _navigator.goto(SharedRoutes.post);
                                },
                                onPostTap: () {
                                  final postDetailsStore =
                                      getIt<PostDetailsStore>();
                                  postDetailsStore.setSelectedPost(post);
                                  _navigator.goto(SharedRoutes.postDetails);
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
