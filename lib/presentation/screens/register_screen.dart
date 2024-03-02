import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xff80608B),
        appBar: AppBar(
          backgroundColor: const Color(0xff80608B),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Registrate',
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffffff)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
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
                child: const LoginFormRegister(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginFormRegister extends ConsumerWidget {
  const LoginFormRegister({super.key});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showSnackBar(context, next.message);
      if (next.authStatus == AuthStatus.newUserRegistred) context.go('/login');
    });

    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              label: 'Nombre',
              onChanged: ref.read(registerFormProvider.notifier).onNameChange,
              errorMessage: registerForm.isFormPosted
                  ? registerForm.name.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Apellido',
              onChanged:
                  ref.read(registerFormProvider.notifier).onLastNameChange,
              errorMessage: registerForm.isFormPosted
                  ? registerForm.lastName.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Matrícula',
              onChanged:
                  ref.read(registerFormProvider.notifier).onStudentEnrollmentChanged,
              errorMessage: registerForm.isFormPosted
                  ? registerForm.studentEnrollment.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Correo electrónico',
              onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
              errorMessage: registerForm.isFormPosted
                  ? registerForm.email.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Contraseña',
              isObscureText: true,
              onChanged:
                  ref.read(registerFormProvider.notifier).onPasswordChange,
              errorMessage: registerForm.isFormPosted
                  ? registerForm.password.errorMessage
                  : null,
              onFieldSubmitted: ( _ ) => ref.read(registerFormProvider.notifier).onFormSubmit(),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: registerForm.isPosting
                      ? null
                      : ref.read(registerFormProvider.notifier).onFormSubmit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: const Color(0xff5A4361),
                      foregroundColor: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Registrarse',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Ya tienes cuenta? ',
                  style: TextStyle(fontSize: 18, color: Color(0xff303030)),
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/login');
                  },
                  child: const Text(
                    'Inicia Sesión',
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
      ),
    ));
  }
}
