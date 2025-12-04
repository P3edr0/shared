import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:shared/domain/entities/login_entity.dart';
import 'package:shared/domain/entities/login_response_entity.dart';
import 'package:shared/domain/usecases/auth/login/login_usecase.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase({required this.loginUseCase});

  final LoginUseCase loginUseCase;
  @observable
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginResponseEntity? loginResponse;
  String? exception;
  final formKey = GlobalKey<FormState>();

  Future<LoginResponseEntity?> login() async {
    setLoading();
    final email = emailController.text;
    final password = passwordController.text;
    final LoginEntity login = LoginEntity(email: email, password: password);
    final response = await loginUseCase(login);
    return response.fold(
      (newException) {
        exception = newException.message;
        setLoading();

        return null;
      },
      (newLoginResponse) {
        exception = null;

        loginResponse = newLoginResponse;
        setLoading();

        return loginResponse;
      },
    );
  }

  @action
  setLoading([bool? newLoading]) {
    if (newLoading == null) {
      isLoading = !isLoading;
      return;
    }
    isLoading = newLoading;
  }
}
