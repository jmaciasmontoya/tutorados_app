import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class RegisterTutorScreen extends StatelessWidget {
  const RegisterTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Color(colors.surface.value),
      appBar: AppBar(
        backgroundColor: Color(colors.surface.value),
        iconTheme: IconThemeData(color: Color(colors.onSurface.value)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text('Registrar tutor',
                style: TextStyle(
                    color: Color(colors.secondary.value),
                    fontSize: 32,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(colors.primaryContainer.value),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: const Center(child: _RegisterForm()),
            ),
          )
        ],
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerTutorProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showSnackBar(context, next.message);
    });

    void showDialogInfo(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return const TutorInfo();
        },
      ).then((value) => {
            ref.read(registerTutorProvider.notifier).closeModal(),
            FocusScope.of(context).requestFocus(FocusNode())
          });
    }

    ref.listen(registerTutorProvider, (previous, next) {
      if (next.userRegistred == false) return;
      showDialogInfo(context);
    });

    final registerTutorState = ref.watch(registerTutorProvider);
    final colors = Theme.of(context).colorScheme;
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              isFormStudent: true,
              label: 'Nombre',
              onChanged: ref.read(registerTutorProvider.notifier).onNameChange,
              errorMessage: registerTutorState.isFormPosted
                  ? registerTutorState.name.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              isFormStudent: true,
              label: 'Apellido',
              onChanged:
                  ref.read(registerTutorProvider.notifier).onLastNameChange,
              errorMessage: registerTutorState.isFormPosted
                  ? registerTutorState.lastName.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              isFormStudent: true,
              label: 'Correo electrónico',
              onChanged: ref.read(registerTutorProvider.notifier).onEmailChange,
              errorMessage: registerTutorState.isFormPosted
                  ? registerTutorState.email.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Color(colors.primary.value),
                      foregroundColor: Color(colors.onPrimary.value)),
                  onPressed: registerTutorState.isPosting
                      ? null
                      : ref.read(registerTutorProvider.notifier).onFormSubmit,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Registrar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

class TutorInfo extends ConsumerWidget {
  const TutorInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutorInfoState = ref.watch(registerTutorProvider);
    final colors = Theme.of(context).colorScheme;
    final styles = TextStyle(
        color: Color(colors.secondary.value),
        fontWeight: FontWeight.w700,
        fontSize: 16);
    return AlertDialog(
        backgroundColor: Color(colors.primaryContainer.value),
        title: Center(
            child: Text(
          'Información del tutor',
          style: TextStyle(color: Color(colors.onPrimaryContainer.value)),
        )),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton.icon(
              onPressed: () {
                ref.read(registerTutorProvider.notifier).closeModal();
                Navigator.of(context).pop();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: Icon(
                Icons.check,
                color: Color(colors.secondary.value),
              ),
              label: Text(
                'Aceptar',
                style: TextStyle(color: Color(colors.secondary.value)),
              ))
        ],
        content: SizedBox(
          width: double.maxFinite,
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Codigo: ',
                style: styles,
              ),
              Text(
                '${tutorInfoState.tutorInfo['usuario_id']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(colors.onPrimaryContainer.value)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Nombre: ', style: styles),
              Text(
                '${tutorInfoState.tutorInfo['nombre']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(colors.onPrimaryContainer.value)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Apellido:', style: styles),
              Text(
                ' ${tutorInfoState.tutorInfo['apellido']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(colors.onPrimaryContainer.value)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Correo: ', style: styles),
              Text(
                '${tutorInfoState.tutorInfo['correo']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(colors.onPrimaryContainer.value)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Contraseña: ', style: styles),
              Text(
                '${tutorInfoState.tutorInfo['contraseña']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(colors.onPrimaryContainer.value)),
              ),
            ],
          ),
        ));
  }
}
