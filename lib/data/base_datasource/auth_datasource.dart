import 'package:dartz/dartz.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/exceptions/shared_exceptions.dart';

abstract class ILoginDatasource {
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  );
}

abstract class ICreateAccountDatasource {
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  );
}

abstract class ILogoutDatasource {
  Future<Either<ISharedExceptions, bool>> call();
}

abstract class IForgotPasswordDatasource {
  Future<Either<ISharedExceptions, bool>> call(String email);
}

abstract class IResetPasswordDatasource {
  Future<Either<ISharedExceptions, bool>> call(String email);
}
