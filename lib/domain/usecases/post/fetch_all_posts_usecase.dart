import 'package:dartz/dartz.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/domain/repository/post/post_repository.dart';

import '../../exceptions/shared_exceptions.dart';

class FetchAllPostsUsecase {
  final IFetchAllPostsRepository repository;

  FetchAllPostsUsecase({required this.repository});

  Future<Either<ISharedExceptions, List<PostEntity>>> call() async {
    return await repository();
  }
}
