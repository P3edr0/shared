import 'package:shared/domain/entities/post_entity.dart';

class UserEntity {
  UserEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.posts,
    required this.friends,
  });
  String id;
  String name;
  String image;
  List<PostEntity> posts;
  List<UserEntity> friends;
}
