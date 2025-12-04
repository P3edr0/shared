import 'package:dartz/dartz.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/post/post_repository.dart';
import '../../base_datasource/post_datasource.dart';

class FetchAllPostsRepositoryImp implements IFetchAllPostsRepository {
  final IFetchAllPostsDatasource datasource;

  FetchAllPostsRepositoryImp({required this.datasource});

  @override
  Future<Either<ISharedExceptions, List<PostEntity>>> call() async {
    return await datasource();
  }
}
