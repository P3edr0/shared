import 'package:dartz/dartz.dart';

import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import '../../base_datasource/auth_datasource.dart';

class ResetPasswordRepositoryImpl implements IResetPasswordRepository {
  ResetPasswordRepositoryImpl({required this.datasource});
  IResetPasswordDatasource datasource;
  @override
  Future<Either<ISharedExceptions, bool>> call(String email) async {
    final response = await datasource.call(email);
    return response;
  }
}
