// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostDetailsStore on PostDetailsStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'PostDetailsStoreBase.isLoading',
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

  late final _$_selectedImageAtom = Atom(
    name: 'PostDetailsStoreBase._selectedImage',
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

  late final _$_selectedPostAtom = Atom(
    name: 'PostDetailsStoreBase._selectedPost',
    context: context,
  );

  @override
  PostEntity? get _selectedPost {
    _$_selectedPostAtom.reportRead();
    return super._selectedPost;
  }

  @override
  set _selectedPost(PostEntity? value) {
    _$_selectedPostAtom.reportWrite(value, super._selectedPost, () {
      super._selectedPost = value;
    });
  }

  late final _$postsAtom = Atom(
    name: 'PostDetailsStoreBase.posts',
    context: context,
  );

  @override
  List<PostEntity> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<PostEntity> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$PostDetailsStoreBaseActionController = ActionController(
    name: 'PostDetailsStoreBase',
    context: context,
  );

  @override
  dynamic setLoading([bool? newLoading]) {
    final _$actionInfo = _$PostDetailsStoreBaseActionController.startAction(
      name: 'PostDetailsStoreBase.setLoading',
    );
    try {
      return super.setLoading(newLoading);
    } finally {
      _$PostDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPost(PostEntity newPost) {
    final _$actionInfo = _$PostDetailsStoreBaseActionController.startAction(
      name: 'PostDetailsStoreBase.setSelectedPost',
    );
    try {
      return super.setSelectedPost(newPost);
    } finally {
      _$PostDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  UserEntity getUser(String id) {
    final _$actionInfo = _$PostDetailsStoreBaseActionController.startAction(
      name: 'PostDetailsStoreBase.getUser',
    );
    try {
      return super.getUser(id);
    } finally {
      _$PostDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
posts: ${posts}
    ''';
  }
}
