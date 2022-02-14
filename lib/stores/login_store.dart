import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_clone/repositories/user_repository.dart';

import '../helpers/extensions.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.length >= 4;
  String? get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  bool get isFormValid => emailValid && passwordValid;
  VoidCallback? get loginPressed => isFormValid && !isLoading ? _login : null;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> _login() async {
    isLoading = true;

    try {
      final resultUser = await UserRepository().loginWithEmail(
        email!,
        password!,
      );
      error = null;
    } catch (e) {
      error = e as String;
    }

    isLoading = false;
  }
}
