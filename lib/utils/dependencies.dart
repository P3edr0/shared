import 'package:get_it/get_it.dart';
import 'package:shared/data/base_datasource/auth_datasource.dart';
import 'package:shared/data/firebase/auth/login.dart';
import 'package:shared/data/firebase/auth/recover_password.dart';
import 'package:shared/data/repository/auth/login_repository_impl.dart';
import 'package:shared/data/repository/post/fetch_all_posts_repository_impl.dart'
    show FetchAllPostsRepositoryImp;
import 'package:shared/domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';
import 'package:shared/domain/exceptions/datasource_exceptions/firebase_exceptions.dart';
import 'package:shared/domain/usecases/auth/login/login_usecase.dart';
import 'package:shared/presenter/auth/create_account/store/create_account_store.dart';
import 'package:shared/presenter/auth/login/store/login_store.dart';
import 'package:shared/presenter/home/store/home_store.dart';
import 'package:shared/presenter/post_details_page/store/post_details_store.dart';
import 'package:shared/presenter/post_page/store/post_store.dart';
import 'package:shared/services/image_picker/image_picker_service.dart';
import 'package:shared/services/image_picker/image_picker_service_impl.dart';

import '../data/base_datasource/post_datasource.dart';
import '../data/firebase/auth/create_account.dart';
import '../data/firebase/post/create_post.dart';
import '../data/firebase/post/delete_post.dart';
import '../data/firebase/post/fetch_all_posts.dart';
import '../data/firebase/post/update_post.dart';
import '../data/repository/auth/create_account_repository_impl.dart';
import '../data/repository/auth/recover_password_repository_impl.dart';
import '../data/repository/post/create_post_repository_impl.dart';
import '../data/repository/post/delete_post_repository_impl.dart';
import '../data/repository/post/update_post_repository_impl.dart';
import '../domain/repository/auth/auth_repository.dart';
import '../domain/repository/post/post_repository.dart';
import '../domain/usecases/auth/create_account/create_account_usecase.dart';
import '../domain/usecases/auth/recover_password/recover_password_usecase.dart';
import '../domain/usecases/post/create_post_usecase.dart';
import '../domain/usecases/post/delete_post_usecase.dart';
import '../domain/usecases/post/fetch_all_posts_usecase.dart';
import '../domain/usecases/post/update_post_usecase.dart';
import '../presenter/auth/reset_password/store/reset_password_store.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // SERVICES DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IImagePickerService>(ImagePickerServiceImpl());
  // DATABASE DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IDatasourceExceptionManager>(
    FirebaseExceptionManager(),
  );

  //++++++++++++++++ AUTH DEPENDENCIES ++++++++++++++++
  // LOGIN DEPENDENCIES ++++++++++++++++

  getIt.registerSingleton<ILoginDatasource>(FirebaseLoginDatasource());
  getIt.registerSingleton<ILoginRepository>(
    LoginRepositoryImpl(datasource: getIt<ILoginDatasource>()),
  );
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(repository: getIt<ILoginRepository>()),
  );
  getIt.registerSingleton<LoginStore>(
    LoginStore(loginUseCase: getIt<LoginUseCase>()),
  );

  // CREATE ACCOUNT DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<ICreateAccountDatasource>(
    FirebaseCreateAccountDatasource(),
  );
  getIt.registerSingleton<ICreateAccountRepository>(
    CreateAccountRepositoryImpl(datasource: getIt<ICreateAccountDatasource>()),
  );
  getIt.registerSingleton<CreateAccountUseCase>(
    CreateAccountUseCase(repository: getIt<ICreateAccountRepository>()),
  );
  getIt.registerSingleton<CreateAccountStore>(
    CreateAccountStore(createAccountUseCase: getIt<CreateAccountUseCase>()),
  );

  // RECOVER ACCOUNT DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IResetPasswordDatasource>(FirebaseResetPassword());
  getIt.registerSingleton<IResetPasswordRepository>(
    ResetPasswordRepositoryImpl(datasource: getIt<IResetPasswordDatasource>()),
  );
  getIt.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(repository: getIt<IResetPasswordRepository>()),
  );
  getIt.registerSingleton<ResetPasswordStore>(
    ResetPasswordStore(resetPasswordUseCase: getIt<ResetPasswordUseCase>()),
  );

  //++++++++++++++++ POST DEPENDENCIES ++++++++++++++++
  // CREATE POST DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<ICreatePostDatasource>(
    FirebaseCreatePostDatasource(),
  );
  getIt.registerSingleton<ICreatePostRepository>(
    CreatePostRepositoryImp(datasource: getIt<ICreatePostDatasource>()),
  );
  getIt.registerSingleton<CreatePostUsecase>(
    CreatePostUsecase(repository: getIt<ICreatePostRepository>()),
  );

  // UPDATE POST DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IUpdatePostDatasource>(
    FirebaseUpdatePostDatasource(),
  );
  getIt.registerSingleton<IUpdatePostRepository>(
    UpdatePostRepositoryImp(datasource: getIt<IUpdatePostDatasource>()),
  );
  getIt.registerSingleton<UpdatePostUsecase>(
    UpdatePostUsecase(repository: getIt<IUpdatePostRepository>()),
  );

  // DELETE POST DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IDeletePostDatasource>(
    FirebaseDeletePostDatasource(),
  );
  getIt.registerSingleton<IDeletePostRepository>(
    DeletePostRepositoryImp(datasource: getIt<IDeletePostDatasource>()),
  );
  getIt.registerSingleton<DeletePostUsecase>(
    DeletePostUsecase(repository: getIt<IDeletePostRepository>()),
  );
  getIt.registerSingleton<PostStore>(
    PostStore(
      createPostUsecase: getIt<CreatePostUsecase>(),
      updatePostUsecase: getIt<UpdatePostUsecase>(),
      deletePostUsecase: getIt<DeletePostUsecase>(),
    ),
  );
  // POST DETAILS DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<PostDetailsStore>(
    PostDetailsStore(
      updatePostUsecase: getIt<UpdatePostUsecase>(),
      deletePostUsecase: getIt<DeletePostUsecase>(),
    ),
  );
  //++++++++++++++++ HOME DEPENDENCIES ++++++++++++++++
  getIt.registerSingleton<IFetchAllPostsDatasource>(
    FirebaseFetchAllPostsDatasource(),
  );
  getIt.registerSingleton<IFetchAllPostsRepository>(
    FetchAllPostsRepositoryImp(datasource: getIt<IFetchAllPostsDatasource>()),
  );
  getIt.registerSingleton<FetchAllPostsUsecase>(
    FetchAllPostsUsecase(repository: getIt<IFetchAllPostsRepository>()),
  );
  getIt.registerSingleton<HomeStore>(
    HomeStore(fetchAllPostsUsecase: getIt<FetchAllPostsUsecase>()),
  );
}
