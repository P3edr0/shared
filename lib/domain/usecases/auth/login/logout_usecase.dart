import 'package:dartz/dartz.dart';

import '../../../exceptions/shared_exceptions.dart';
import '../../../repository/auth/auth_repository.dart';

class LogoutUseCase {
  final ILogoutRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<ISharedExceptions, bool>> call() async {
    return repository();
  }
}
