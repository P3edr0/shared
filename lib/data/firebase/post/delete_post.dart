import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../utils/dependencies.dart';
import '../../../utils/framework/jack_environment.dart';
import '../../base_datasource/post_datasource.dart';

class FirebaseDeletePostDatasource implements IDeletePostDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<Either<ISharedExceptions, bool>> deleteMedia(
    String oldMediaPath,
  ) async {
    try {
      final oldMediaRef = storage.ref().child(oldMediaPath);

      await oldMediaRef.delete();

      return Right(true);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      log(e.toString());
      return Left(BadRequestSharedException());
    }
  }

  @override
  Future<Either<ISharedExceptions, bool>> deletePostData(String id) async {
    try {
      await firestore
          .collection(SharedEnvironment.postsCollection)
          .doc(id)
          .delete();
      return Right(true);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      log(e.toString());
      return Left(BadRequestSharedException());
    }
  }
}
