import 'package:dartz/dartz.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/domain/repository/post/post_repository.dart';

import '../../exceptions/shared_exceptions.dart';

class DeletePostUsecase {
  final IDeletePostRepository repository;

  DeletePostUsecase({required this.repository});

  Future<Either<ISharedExceptions, bool>> call(PostEntity post) async {
    if (post.id.trim().isEmpty) {
      return Left(DataException(message: 'O id não pode ser vazio'));
    }
    return await repository(post);
  }
}
