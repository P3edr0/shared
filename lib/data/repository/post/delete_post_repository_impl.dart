import 'package:dartz/dartz.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/post/post_repository.dart';
import '../../base_datasource/post_datasource.dart';

class DeletePostRepositoryImp implements IDeletePostRepository {
  final IDeletePostDatasource datasource;

  DeletePostRepositoryImp({required this.datasource});

  @override
  Future<Either<ISharedExceptions, bool>> call(PostEntity post) async {
    await datasource.deletePostData(post.id);
    return await datasource.deleteMedia(post.contentPath!);
  }
}
