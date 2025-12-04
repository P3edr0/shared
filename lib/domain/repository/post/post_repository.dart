import 'package:dartz/dartz.dart';
import 'package:shared/domain/entities/post_entity.dart';

import '../../exceptions/shared_exceptions.dart';

abstract class ICreatePostRepository {
  Future<Either<ISharedExceptions, bool>> call(PostEntity post);
}

abstract class IUpdatePostRepository {
  Future<Either<ISharedExceptions, bool>> call(PostEntity post);
}

abstract class IDeletePostRepository {
  Future<Either<ISharedExceptions, bool>> call(PostEntity post);
}

abstract class IFetchAllPostsRepository {
  Future<Either<ISharedExceptions, List<PostEntity>>> call();
}
