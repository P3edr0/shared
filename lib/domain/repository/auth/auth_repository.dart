import 'package:dartz/dartz.dart';

import '../../entities/login_entity.dart';
import '../../entities/login_response_entity.dart';
import '../../exceptions/shared_exceptions.dart';

abstract class ILoginRepository {
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  );
}

abstract class ICreateAccountRepository {
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  );
}

abstract class ILogoutRepository {
  Future<Either<ISharedExceptions, bool>> call();
}

abstract class IForgotPasswordRepository {
  Future<Either<ISharedExceptions, bool>> call(String email);
}

abstract class IResetPasswordRepository {
  Future<Either<ISharedExceptions, bool>> call(String email);
}
