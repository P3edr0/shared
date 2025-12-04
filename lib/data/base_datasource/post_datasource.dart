import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shared/domain/entities/post_entity.dart';

import '../../domain/entities/media_response_entity.dart';
import '../../domain/exceptions/shared_exceptions.dart';

abstract class ICreatePostDatasource {
  Future<Either<ISharedExceptions, MediaResponseEntity>> uploadMedia(
    File file,
    String userId,
  );
  Future<Either<ISharedExceptions, bool>> savePostData(
    Map<String, dynamic> data,
    String id,
  );
}

abstract class IUpdatePostDatasource {
  Future<Either<ISharedExceptions, MediaResponseEntity>> updateMedia(
    File file,
    String userId,
    String oldMediaPath,
  );
  Future<Either<ISharedExceptions, bool>> updatePostData(
    Map<String, dynamic> data,
    String id,
  );
}

abstract class IDeletePostDatasource {
  Future<Either<ISharedExceptions, bool>> deleteMedia(String oldMediaPath);
  Future<Either<ISharedExceptions, bool>> deletePostData(String id);
}

abstract class IFetchAllPostsDatasource {
  Future<Either<ISharedExceptions, List<PostEntity>>> call();
}
