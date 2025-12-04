import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:shared/domain/entities/post_entity.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/post/delete_post_usecase.dart';
import '../../../domain/usecases/post/update_post_usecase.dart';
import '../../../utils/assets.dart';

part 'post_details_store.g.dart';

class PostDetailsStore = PostDetailsStoreBase with _$PostDetailsStore;

abstract class PostDetailsStoreBase with Store {
  PostDetailsStoreBase({
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  });
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final List<UserEntity> users = [
    UserEntity(
      id: '1',
      name: 'Pedro Kamargo',
      image: SharedAssets.student,
      posts: [],
      friends: [],
    ),
  ];
  @observable
  bool isLoading = false;

  @observable
  File? _selectedImage;

  @observable
  PostEntity? _selectedPost;
  ////////////// GET /////////////////////////
  PostEntity? get selectedPost => _selectedPost;

  @action
  setLoading([bool? newLoading]) {
    if (newLoading == null) {
      isLoading = !isLoading;
      return;
    }
    isLoading = newLoading;
  }

  @action
  void setSelectedPost(PostEntity newPost) {
    _selectedPost = newPost;
  }

  String? getFileName() {
    String? fileName = _selectedPost!.contentPath!.split('/').last;

    return fileName;
  }

  @observable
  List<PostEntity> posts = [];
  @action
  UserEntity getUser(String id) {
    final user = users.firstWhere((element) => element.id == id);
    return user;
  }
}
