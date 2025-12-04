import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/usecases/auth/recover_password/recover_password_usecase.dart';

part 'reset_password_store.g.dart';

class ResetPasswordStore = ResetPasswordStoreBase with _$ResetPasswordStore;

abstract class ResetPasswordStoreBase with Store {
  ResetPasswordStoreBase({required this.resetPasswordUseCase});
  final formKey = GlobalKey<FormState>();
  final ResetPasswordUseCase resetPasswordUseCase;
  @observable
  bool isLoading = false;
  String? exception;
  TextEditingController emailController = TextEditingController();

  @action
  setLoading([bool? newLoading]) {
    if (newLoading == null) {
      isLoading = !isLoading;
      return;
    }
    isLoading = newLoading;
  }

  @action
  Future<bool> resetPassword() async {
    setLoading();
    final email = emailController.text;

    final response = await resetPasswordUseCase(email);
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
