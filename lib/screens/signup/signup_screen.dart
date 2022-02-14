import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_clone/components/buttons/custom_elevated_button.dart';
import 'package:olx_clone/components/error_box.dart';
import 'package:olx_clone/screens/signup/components/field_title.dart';
import 'package:olx_clone/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpStore signUpStore = SignUpStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Observer(
                    builder: (_) {
                      return ErrorBox(message: signUpStore.error);
                    },
                  ),
                  const FieldTitle(
                    title: 'Apelido',
                    subTitle: 'Como aparecerá em seus anúncios.',
                  ),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.isLoading,
                        decoration: InputDecoration(
                          hintText: 'Exemplo: João S.',
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.nameError,
                        ),
                        onChanged: signUpStore.setName,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const FieldTitle(
                    title: 'E-mail',
                    subTitle: 'Enviaremos um e-mail de conrfirmação.',
                  ),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.isLoading,
                        decoration: InputDecoration(
                          hintText: 'Exemplo: joao@gmail.com',
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signUpStore.setEmail,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const FieldTitle(
                    title: 'Celular',
                    subTitle: 'Proteja sua conta.',
                  ),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.isLoading,
                        decoration: InputDecoration(
                          hintText: '(99) 99999-9999',
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: signUpStore.setPhone,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const FieldTitle(
                    title: 'Senha',
                    subTitle: 'Use letras, números e caracteres especiais.',
                  ),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.isLoading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.passwordError,
                        ),
                        obscureText: true,
                        onChanged: signUpStore.setPassword,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const FieldTitle(
                    title: 'Confirmar Senha',
                    subTitle: 'Repita a senha.',
                  ),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.isLoading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.passwordValidatorError,
                        ),
                        obscureText: true,
                        onChanged: signUpStore.setPasswordValidator,
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return CustomElevatedButton(
                        title: 'CADASTRAR',
                        isLoading: signUpStore.isLoading,
                        onPressed: signUpStore.signUpPressed,
                      );
                    },
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          'Já tem uma conta? ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.purple,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
