import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../helpers/extensions.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'user_manager_store.dart';

part 'signup_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  @observable
  String? name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length > 6;
  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'Nome muito curto.';
    }
  }

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'E-mail inválido.';
    }
  }

  @observable
  String? phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length >= 14;
  String? get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'Celular inválido.';
    }
  }

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.length >= 6;
  String? get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else if (password!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'Senha muito curta.';
    }
  }

  @observable
  String? passwordValidator;

  @action
  void setPasswordValidator(String value) => passwordValidator = value;

  @computed
  bool get passwordValidatorValid =>
      passwordValidator != null && passwordValidator == password;
  String? get passwordValidatorError {
    if (passwordValidator == null || passwordValidatorValid) {
      return null;
    } else {
      return 'Senha não coincidem.';
    }
  }

  @computed
  bool get isFormValid =>
      nameValid &&
      emailValid &&
      phoneValid &&
      passwordValid &&
      passwordValidatorValid;

  @computed
  VoidCallback? get signUpPressed =>
      (isFormValid && !isLoading) ? _signUp : null;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> _signUp() async {
    isLoading = true;

    final user = User(
      name: name!,
      email: email!,
      phone: phone!,
      password: password!,
    );

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch (e) {
      error = e as String;
    }

    isLoading = false;
  }
}
