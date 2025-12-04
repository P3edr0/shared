import 'package:dartz/dartz.dart';
import 'package:shared/domain/exceptions/shared_exceptions.dart';

import '../../../repository/auth/auth_repository.dart';

class ResetPasswordUseCase {
  final IResetPasswordRepository repository;

  ResetPasswordUseCase({required this.repository});
  Future<Either<ISharedExceptions, bool>> call(String email) async {
    if (email.trim().isEmpty) {
      return Left(DataException(message: 'O email não pode ser vazio'));
    }

    return repository(email);
  }
}
