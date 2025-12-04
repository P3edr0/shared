// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on PostStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'PostStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pageTypeAtom = Atom(
    name: 'PostStoreBase.pageType',
    context: context,
  );

  @override
  PageType get pageType {
    _$pageTypeAtom.reportRead();
    return super.pageType;
  }

  @override
  set pageType(PageType value) {
    _$pageTypeAtom.reportWrite(value, super.pageType, () {
      super.pageType = value;
    });
  }

  late final _$_selectedImageAtom = Atom(
    name: 'PostStoreBase._selectedImage',
    context: context,
  );

  @override
  File? get _selectedImage {
    _$_selectedImageAtom.reportRead();
    return super._selectedImage;
  }

  @override
  set _selectedImage(File? value) {
    _$_selectedImageAtom.reportWrite(value, super._selectedImage, () {
      super._selectedImage = value;
    });
  }

  late final _$_selectedVideoAtom = Atom(
    name: 'PostStoreBase._selectedVideo',
    context: context,
  );

  @override
  File? get _selectedVideo {
    _$_selectedVideoAtom.reportRead();
    return super._selectedVideo;
  }

  @override
  set _selectedVideo(File? value) {
    _$_selectedVideoAtom.reportWrite(value, super._selectedVideo, () {
      super._selectedVideo = value;
    });
  }

  late final _$_selectedToEditPostAtom = Atom(
    name: 'PostStoreBase._selectedToEditPost',
    context: context,
  );

  @override
  PostEntity? get _selectedToEditPost {
    _$_selectedToEditPostAtom.reportRead();
    return super._selectedToEditPost;
  }

  @override
  set _selectedToEditPost(PostEntity? value) {
    _$_selectedToEditPostAtom.reportWrite(value, super._selectedToEditPost, () {
      super._selectedToEditPost = value;
    });
  }

  late final _$createPostAsyncAction = AsyncAction(
    'PostStoreBase.createPost',
    context: context,
  );

  @override
  Future<bool> createPost() {
    return _$createPostAsyncAction.run(() => super.createPost());
  }

  late final _$updatePostAsyncAction = AsyncAction(
    'PostStoreBase.updatePost',
    context: context,
  );

  @override
  Future<bool> updatePost(PostEntity newPost) {
    return _$updatePostAsyncAction.run(() => super.updatePost(newPost));
  }

  late final _$deletePostAsyncAction = AsyncAction(
    'PostStoreBase.deletePost',
    context: context,
  );

  @override
  Future<bool> deletePost(PostEntity newPost) {
    return _$deletePostAsyncAction.run(() => super.deletePost(newPost));
  }

  late final _$PostStoreBaseActionController = ActionController(
    name: 'PostStoreBase',
    context: context,
  );

  @override
  dynamic setSelectedVideo(File? newSelectedVideo) {
    final _$actionInfo = _$PostStoreBaseActionController.startAction(
      name: 'PostStoreBase.setSelectedVideo',
    );
    try {
      return super.setSelectedVideo(newSelectedVideo);
    } finally {
      _$PostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedImage(File? newSelectedImage) {
    final _$actionInfo = _$PostStoreBaseActionController.startAction(
      name: 'PostStoreBase.setSelectedImage',
    );
    try {
      return super.setSelectedImage(newSelectedImage);
    } finally {
      _$PostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading([bool? newLoading]) {
    final _$actionInfo = _$PostStoreBaseActionController.startAction(
      name: 'PostStoreBase.setLoading',
    );
    try {
      return super.setLoading(newLoading);
    } finally {
      _$PostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPageType(PageType newPageType, PostEntity? newPost) {
    final _$actionInfo = _$PostStoreBaseActionController.startAction(
      name: 'PostStoreBase.setPageType',
    );
    try {
      return super.setPageType(newPageType, newPost);
    } finally {
      _$PostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pageType: ${pageType}
    ''';
  }
}
