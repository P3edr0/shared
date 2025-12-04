abstract class ISharedExceptions implements Exception {
  String message = "Falha na autenticação.";
  ISharedExceptions({required this.message});
}

class EmailAlreadyExistsException extends ISharedExceptions {
  @override
  EmailAlreadyExistsException({super.message = "E-mail já cadastrado."});
}

class TooManyAttemptsException extends ISharedExceptions {
  @override
  TooManyAttemptsException({
    super.message = 'Acesso bloqueado temporariamente. Tente mais tarde.',
  });
}

class DataException extends ISharedExceptions {
  @override
  DataException({super.message = "Dado inválido."});
}

class BadRequestSharedException extends ISharedExceptions {
  @override
  BadRequestSharedException({
    super.message = "Falha ao tentar acessar. Por favor tente mais tarde",
  });
}

class EmailOrPasswordException extends ISharedExceptions {
  @override
  EmailOrPasswordException({super.message = "Email ou senha estão incorretos"});
}

class InvalidPasswordException extends ISharedExceptions {
  @override
  InvalidPasswordException({super.message = "Senha informada não confere"});
}
