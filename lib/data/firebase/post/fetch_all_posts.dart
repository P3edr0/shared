import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/domain/entities/post_entity.dart';
import 'package:shared/domain/exceptions/shared_exceptions.dart';

import '../../../domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import '../../../utils/dependencies.dart';
import '../../../utils/enums/post_type.dart';
import '../../../utils/framework/jack_environment.dart';
import '../../base_datasource/post_datasource.dart';

class FirebaseFetchAllPostsDatasource implements IFetchAllPostsDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<Either<ISharedExceptions, List<PostEntity>>> call() async {
    try {
      final query = await firestore
          .collection(SharedEnvironment.postsCollection)
          .get();

      final posts = query.docs.map((doc) {
        final data = doc.data();

        return PostEntity(
          id: doc.id,
          type: PostType.translate(data["type"]),
          userId: data["userId"],
          subtitle: data["subtitle"],
          date: DateTime.tryParse(data["date"]) ?? DateTime.now(),
          contentUrl: data["contentUrl"],
          contentPath: data["contentPath"],
          likes: data["likes"] ?? 0,
          comments: List<String>.from(data["comments"] ?? []),
          shares: data["shares"] ?? 0,
        );
      }).toList();

      return Right(posts);
    } on FirebaseAuthException catch (e) {
      final exceptionManager = getIt<IDatasourceExceptionManager>();
      return Left(exceptionManager(e.code));
    } catch (e) {
      log(e.toString());
      return Left(BadRequestSharedException());
    }
  }
}
