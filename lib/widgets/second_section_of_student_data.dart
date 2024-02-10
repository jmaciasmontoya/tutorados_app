import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class SecondSectionOfStudentData extends ConsumerWidget {
  const SecondSectionOfStudentData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final secondStudentData = ref.watch(secondStudentDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          errorMessage: secondStudentData.birthDate.errorMessage,
          label: 'Fecha de nacimiento',
          controller:
              ref.read(secondStudentDataProvider.notifier).birthDateController,
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              ref
                  .read(secondStudentDataProvider.notifier)
                  .onBirthDateChanged(date);
            }
          },
        ),
        CustomTextField(
          errorMessage: secondStudentData.placeOfBirth.errorMessage,
          label: 'Lugar de nacimiento',
          onChanged: ref
              .read(secondStudentDataProvider.notifier)
              .onPlaceOfBirthChanged,
        ),
        CustomTextField(
          label: 'Edad',
          controller:
              ref.read(secondStudentDataProvider.notifier).ageController,
          onChanged: ref.read(secondStudentDataProvider.notifier).onAgeChanged,
        ),
        CustomTextField(
          label: 'Religión',
          hint: 'Ninguna',
          onChanged:
              ref.read(secondStudentDataProvider.notifier).onReligionChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Actividad cultural o deportiva que practiques',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        CustomTextField(
          hint: 'Ninguna',
          onChanged:
              ref.read(secondStudentDataProvider.notifier).onActivityChanged,
        ),
        CustomTextField(
          errorMessage: secondStudentData.tutor.errorMessage,
          label: 'Tutor o padre de familia',
          onChanged:
              ref.read(secondStudentDataProvider.notifier).onTutorChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ref.read(secondStudentDataProvider.notifier).onFormSubmit,
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
