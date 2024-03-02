import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class AssignTutor extends ConsumerWidget {
  const AssignTutor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeState = ref.watch(codeProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        codeState.message.isNotEmpty
            ? Text(
                codeState.message,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w500),
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        const Text('Ingresa el código de tu tutor',
            style: TextStyle(
                color: Color(0xff5A4361),
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: CustomTextField(
            label: 'Código',
            onChanged: ref.read(codeProvider.notifier).onCodeChanged,
            errorMessage:
                codeState.isCodePosted ? codeState.code.errorMessage : null,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: codeState.isCodePosting
              ? null
              : ref.read(codeProvider.notifier).onCodeSubmit,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff5A4361)),
          ),
          child: const Icon(
            Icons.navigate_next,
            color: Color(0xffffffff),
          ),
        ),
      ],
    );
  }
}
