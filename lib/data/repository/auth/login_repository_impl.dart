import 'package:dartz/dartz.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/entities/login_response_entity.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import '../../base_datasource/auth_datasource.dart';

class LoginRepositoryImpl implements ILoginRepository {
  LoginRepositoryImpl({required this.datasource});
  ILoginDatasource datasource;
  @override
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  ) async {
    final response = await datasource(login);
    return response;
  }
}
