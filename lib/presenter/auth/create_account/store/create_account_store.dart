import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/usecases/auth/create_account/create_account_usecase.dart';

part 'create_account_store.g.dart';

class CreateAccountStore = CreateAccountStoreBase with _$CreateAccountStore;

abstract class CreateAccountStoreBase with Store {
  CreateAccountStoreBase({required this.createAccountUseCase});
  final CreateAccountUseCase createAccountUseCase;
  final formKey = GlobalKey<FormState>();
  @observable
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? exception;
  ///////////// GET /////////////////////

  bool get isSamePassword =>
      passwordController.text == confirmPasswordController.text;

  @action
  setLoading([bool? newLoading]) {
    if (newLoading == null) {
      isLoading = !isLoading;
      return;
    }
    isLoading = newLoading;
  }

  @action
  Future<bool> createAccount() async {
    setLoading();
    final email = emailController.text;
    final password = passwordController.text;
    final LoginEntity login = LoginEntity(email: email, password: password);
    final response = await createAccountUseCase(login);
    return response.fold(
      (newException) {
        exception = newException.message;
        setLoading();
        return false;
      },
      (newLoginResponse) {
        exception = null;
        setLoading();

        return true;
      },
    );
  }
}
