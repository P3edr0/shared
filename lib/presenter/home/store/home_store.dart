import 'package:mobx/mobx.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/domain/entities/user_entity.dart';
import 'package:shared/domain/usecases/post/fetch_all_posts_usecase.dart';
import 'package:shared/utils/assets.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase({required this.fetchAllPostsUsecase});
  String? exception;
  @observable
  bool isLoading = false;
  final FetchAllPostsUsecase fetchAllPostsUsecase;
  final List<String> friends = [
    SharedAssets.student,
    SharedAssets.studentThree,
    SharedAssets.student,
    SharedAssets.studentTwo,
    SharedAssets.student,
    SharedAssets.student,
    SharedAssets.student,
  ];
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
  List<PostEntity> posts = [];
  @action
  UserEntity getUser(String id) {
    final user = users.firstWhere((element) => element.id == id);
    return user;
  }

  @action
  void addPost(PostEntity newPost) {
    posts.add(newPost);
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
  Future<void> fetchAllPosts() async {
    setLoading();
    final response = await fetchAllPostsUsecase();
    response.fold(
      (newException) {
        exception = newException.message;
        posts.clear();
      },
      (newPosts) {
        posts = [...newPosts];
      },
    );
    setLoading();
  }

  @action
  Future<void> editPost(PostEntity post) async {
    final response = await fetchAllPostsUsecase();
    response.fold(
      (newException) {
        exception = newException.message;
      },
      (newPosts) {
        posts = [...newPosts];
      },
    );
  }
}
