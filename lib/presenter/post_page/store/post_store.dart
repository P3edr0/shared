import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/domain/usecases/post/create_post_usecase.dart';

import '../../../domain/usecases/post/delete_post_usecase.dart';
import '../../../domain/usecases/post/update_post_usecase.dart';
import '../../../utils/enums/page_type.dart';
import '../../../utils/enums/post_type.dart';

part 'post_store.g.dart';

class PostStore = PostStoreBase with _$PostStore;

abstract class PostStoreBase with Store {
  PostStoreBase({
    required this.createPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  });
  final CreatePostUsecase createPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;
  @observable
  bool isLoading = false;
  @observable
  PageType pageType = PageType.create;
  @observable
  File? _selectedImage;
  @observable
  File? _selectedVideo;
  @observable
  PostEntity? _selectedToEditPost;
  PostType selectedMediaType = PostType.image;
  String? exception;
  final TextEditingController subtitleController = TextEditingController();
  ////////////// GET /////////////////////////
  File? get selectedImage => _selectedImage;
  File? get selectedVideo => _selectedVideo;
  PostEntity? get selectedToEditPost => _selectedToEditPost;

  @action
  setSelectedVideo(File? newSelectedVideo) {
    _selectedVideo = newSelectedVideo;
    if (_selectedVideo != null) {
      selectedMediaType = PostType.video;
    }
  }

  @action
  setSelectedImage(File? newSelectedImage) {
    _selectedImage = newSelectedImage;
    if (selectedImage != null) {
      selectedMediaType = PostType.image;
    }
  }

  @action
  setLoading([bool? newLoading]) {
    if (newLoading == null) {
      isLoading = !isLoading;
      return;
    }
    isLoading = newLoading;
  }

  @action
  setPageType(PageType newPageType, PostEntity? newPost) {
    pageType = newPageType;
    _selectedToEditPost = newPost;
    _selectedImage = null;
    _selectedVideo = null;
    if (newPost != null) {
      subtitleController.text = _selectedToEditPost!.subtitle;
    } else {
      subtitleController.clear();
    }
  }

  String? getFileName() {
    String? fileName;
    if (selectedImage != null) {
      fileName = selectedImage!.path.split('/').last;
    } else if (selectedVideo != null) {
      fileName = selectedVideo!.path.split('/').last;
    } else if (selectedToEditPost != null) {
      fileName = selectedToEditPost!.contentPath!.split('/').last;
    }
    return fileName;
  }

  @action
  Future<bool> createPost() async {
    setLoading();
    final File? content;
    if (selectedMediaType.isImage) {
      content = selectedImage!;
    } else {
      content = selectedVideo;
    }

    final subtitle = subtitleController.text;
    final newPost = PostEntity(
      id: UniqueKey().toString(),
      type: selectedMediaType,
      subtitle: subtitle,
      userId: '1',
      date: DateTime.now(),
      localContent: content,
      likes: 0,
      comments: [],
      shares: 0,
    );

    final response = await createPostUsecase(newPost);
    return response.fold(
      (newException) {
        exception = newException.message;
        setLoading();

        return false;
      },
      (success) {
        exception = null;
        setLoading();

        return true;
      },
    );
  }

  @action
  Future<bool> updatePost(PostEntity newPost) async {
    setLoading();

    final response = await updatePostUsecase(newPost);
    return response.fold(
      (newException) {
        exception = newException.message;
        setLoading();

        return false;
      },
      (success) {
        exception = null;
        setLoading();

        return true;
      },
    );
  }

  @action
  Future<bool> deletePost(PostEntity newPost) async {
    final response = await deletePostUsecase(newPost);
    setLoading();

    return response.fold(
      (newException) {
        exception = newException.message;
        setLoading();

        return false;
      },
      (success) {
        exception = null;
        setLoading();

        return true;
      },
    );
  }
}
