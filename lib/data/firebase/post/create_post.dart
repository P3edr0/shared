import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/domain/entities/media_response_entity.dart';
import 'package:shared/utils/framework/jack_environment.dart';

import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../domain/exceptions/shared_exceptions.dart';
import '../../../utils/dependencies.dart';
import '../../base_datasource/post_datasource.dart';

class FirebaseCreatePostDatasource implements ICreatePostDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<Either<ISharedExceptions, MediaResponseEntity>> uploadMedia(
    File file,
    String userId,
  ) async {
    try {
      final ext = file.path.split('.').last;

      final String path =
          "${SharedEnvironment.postsCollection}/$userId/${DateTime.now().millisecondsSinceEpoch}.$ext";

      final ref = storage.ref().child(path);

      await ref.putFile(file);

      final downloadUrl = await ref.getDownloadURL();
      final response = MediaResponseEntity(url: downloadUrl, path: path);
      return Right(response);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      log(e.toString());
      return Left(BadRequestSharedException());
    }
  }

  @override
  Future<Either<ISharedExceptions, bool>> savePostData(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      await firestore
          .collection(SharedEnvironment.postsCollection)
          .doc(id)
          .set(data);

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
