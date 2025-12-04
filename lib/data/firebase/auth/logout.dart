import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../utils/dependencies.dart';
import '../../base_datasource/auth_datasource.dart';

class FirebaseLogout implements ILogoutDatasource {
  @override
  Future<Either<ISharedExceptions, bool>> call() async {
    final auth = FirebaseAuth.instanceFor(app: Firebase.app());

    try {
      await auth.signOut();

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      return Left(BadRequestSharedException());
    }
  }
}
