import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff80608B),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          backgroundColor: const Color(0xff80608B),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Text('Bienvenido',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 42,
                            fontWeight: FontWeight.bold)),
                    Text(
                      'Por favor ingresa tus datos',
                      style: TextStyle(color: Color(0xffffffff), fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff403046).withOpacity(0.20),
                          offset: const Offset(-4, -4),
                          blurRadius: 20,
                          spreadRadius: 1,
                        )
                      ],
                      color: const Color(0xffffffff),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: const LoginForm(),
                ),
              )
            ],
          )),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showSnackbar(context, next.message);
    });

    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomTextField(
              label: 'Matrícula o correo electrónico',
              onChanged: ref.read(loginFormProvider.notifier).onIdentifierChanged,
              errorMessage:
                  loginForm.isFormPosted ? loginForm.identifier.errorMessage : null,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              isObscureText: true,
              label: 'Contraseña',
              onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
              onFieldSubmitted: ( _ ) => ref.read(loginFormProvider.notifier).onFormSubmit(),
              errorMessage: loginForm.isFormPosted
                  ? loginForm.password.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loginForm.isPosting
                      ? null
                      : ref.read(loginFormProvider.notifier).onFormSubmit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: const Color(0xff5A4361),
                      foregroundColor: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Entrar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No tienes cuenta? ',
                  style: TextStyle(fontSize: 18, color: Color(0xff303030)),
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/register');
                  },
                  child: const Text(
                    'Crear ahora',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff303030)),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
