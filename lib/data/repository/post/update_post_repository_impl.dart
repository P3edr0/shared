import 'package:dartz/dartz.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/post/post_repository.dart';
import '../../base_datasource/post_datasource.dart';

class UpdatePostRepositoryImp implements IUpdatePostRepository {
  final IUpdatePostDatasource datasource;

  UpdatePostRepositoryImp({required this.datasource});

  @override
  Future<Either<ISharedExceptions, bool>> call(PostEntity post) async {
    String? url;
    String? path;
    ISharedExceptions? exception;

    if (post.localContent != null) {
      final result = await datasource.updateMedia(
        post.localContent!,
        post.userId,
        post.contentPath!,
      );
      result.fold(
        (newException) {
          exception = newException;
        },
        (newResponse) {
          url = newResponse.url;
          path = newResponse.path;
        },
      );
    }
    if (exception != null) {
      return Left(exception!);
    }

    final data = {
      "id": post.id,
      "type": post.type.name,
      "userId": post.userId,
      "subtitle": post.subtitle,
      "date": post.date.toIso8601String(),
      "contentUrl": url ?? post.contentUrl,
      "contentPath": path ?? post.contentPath,
      "likes": post.likes,
      "comments": post.comments,
      "shares": post.shares,
    };

    return await datasource.updatePostData(data, post.id);
  }
}
