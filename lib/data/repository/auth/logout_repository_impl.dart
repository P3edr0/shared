import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import '../../base_datasource/auth_datasource.dart';

class LogoutRepositoryImpl implements ILogoutRepository {
  LogoutRepositoryImpl(this.datasource);
  ILogoutDatasource datasource;
  @override
  Future<Either<ISharedExceptions, bool>> call() async {
    final response = await datasource.call();
    return response;
  }
}
