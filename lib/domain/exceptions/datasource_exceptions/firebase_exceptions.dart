import 'package:shared/domain/exceptions/datasource_exceptions/datasource_exception_manager.dart';

import '../shared_exceptions.dart';

class FirebaseExceptionManager extends IDatasourceExceptionManager {
  @override
  ISharedExceptions call(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return EmailOrPasswordException(
          message:
              'Este email já está cadastrado. Tente fazer login ou use outro email.',
        );

      case 'invalid-email':
        return EmailOrPasswordException(
          message:
              'O formato do email é inválido. Verifique e tente novamente.',
        );

      case 'user-not-found':
        return EmailOrPasswordException(
          message: 'Não encontramos uma conta com este email.',
        );

      case 'account-exists-with-different-credential':
        return EmailOrPasswordException(
          message:
              'Já existe uma conta com este email usando outro método de login.',
        );

      case 'weak-password':
        return EmailOrPasswordException(
          message: 'A senha é muito fraca. Use pelo menos 6 caracteres.',
        );

      case 'wrong-password':
        return EmailOrPasswordException(
          message: 'Senha incorreta. Tente novamente.',
        );

      case 'operation-not-allowed':
        return EmailOrPasswordException(
          message: 'Este método de login não está habilitado.',
        );

      case 'network-request-failed':
        return EmailOrPasswordException(
          message:
              'Problema de conexão. Verifique sua internet e tente novamente.',
        );

      case 'too-many-requests':
        return EmailOrPasswordException(
          message:
              'Muitas tentativas. Aguarde alguns minutos e tente novamente.',
        );

      default:
        return EmailOrPasswordException(
          message: 'Esta conta foi desativada. Entre em contato com o suporte.',
        );
    }
  }
}
