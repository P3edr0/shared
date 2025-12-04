import 'package:dartz/dartz.dart';

import '../../../entities/login_entity.dart';
import '../../../entities/login_response_entity.dart';
import '../../../exceptions/shared_exceptions.dart';
import '../../../repository/auth/auth_repository.dart';

class LoginUseCase {
  final ILoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  ) async {
    if (login.email.trim().isEmpty) {
      return Left(DataException(message: 'O email não pode ser vazio'));
    }
    if (login.password.trim().isEmpty) {
      return Left(DataException(message: 'A senha não pode ser vazia'));
    }

    return repository(login);
  }
}
