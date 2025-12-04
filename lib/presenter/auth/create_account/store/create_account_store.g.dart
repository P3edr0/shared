// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateAccountStore on CreateAccountStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'CreateAccountStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$createAccountAsyncAction = AsyncAction(
    'CreateAccountStoreBase.createAccount',
    context: context,
  );

  @override
  Future<bool> createAccount() {
    return _$createAccountAsyncAction.run(() => super.createAccount());
  }

  late final _$CreateAccountStoreBaseActionController = ActionController(
    name: 'CreateAccountStoreBase',
    context: context,
  );

  @override
  dynamic setLoading([bool? newLoading]) {
    final _$actionInfo = _$CreateAccountStoreBaseActionController.startAction(
      name: 'CreateAccountStoreBase.setLoading',
    );
    try {
      return super.setLoading(newLoading);
    } finally {
      _$CreateAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
