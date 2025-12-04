import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/entities/login_response_entity.dart';
import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../utils/dependencies.dart';
import '../../base_datasource/auth_datasource.dart';
import '../../mapper/login_response_mapper.dart';

class FirebaseCreateAccountDatasource implements ICreateAccountDatasource {
  @override
  Future<Either<ISharedExceptions, LoginResponseEntity>> call(
    LoginEntity login,
  ) async {
    final auth = FirebaseAuth.instanceFor(app: Firebase.app());

    try {
      final response = await auth.createUserWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );

      final user = response.user!;
      final data = {
        'email': user.email,
        'tokenId': user.uid,
        'expiresIn': '0',
        'refreshToken': user.refreshToken,
        'registered': true,
      };

      await FirebaseAuth.instance.currentUser?.reload();
      return Right(LoginResponseMapper.fromJson(data));
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      return Left(BadRequestSharedException());
    }
  }
}
