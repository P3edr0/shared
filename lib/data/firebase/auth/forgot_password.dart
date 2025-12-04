import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../utils/dependencies.dart';
import '../../base_datasource/auth_datasource.dart';

class FirebaseForgotPassword implements IForgotPasswordDatasource {
  @override
  Future<Either<ISharedExceptions, bool>> call(String email) async {
    final auth = FirebaseAuth.instanceFor(app: Firebase.app());

    try {
      await auth.sendPasswordResetEmail(email: email);

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      log(e.toString());
      return Left(BadRequestSharedException());
    }
  }
}
