import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class ContactInformationSection extends ConsumerWidget {
  const ContactInformationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactProvider = ref.watch(contactDataProvider);

    return Column(
      children: [
        CustomTextField(
          label: 'Domicilio actual',
          onChanged:
              ref.read(contactDataProvider.notifier).onCurrentAddressChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.currentAddress.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Domicilio familiar',
          onChanged:
              ref.read(contactDataProvider.notifier).onHomeAddressChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.homeAddress.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Celular',
          onChanged:
              ref.read(contactDataProvider.notifier).onCellPhoneNumberChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.cellPhoneNumber.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Tel. Casa',
          onChanged:
              ref.read(contactDataProvider.notifier).onHomePhoneNumberChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.homePhoneNumber.errorMessage
              : null,
        ),
        CustomTextField(
          hint: 'Correo',
          onChanged: ref.read(contactDataProvider.notifier).onEmailChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.email.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Correo del tutor',
          onChanged:
              ref.read(contactDataProvider.notifier).onTutorsEmailChanged,
          errorMessage: contactProvider.isFormPosted
              ? contactProvider.tutorsEmail.errorMessage
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ref.read(contactDataProvider.notifier).onFormSubmit,
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
        ),
      ],
    );
  }
}
