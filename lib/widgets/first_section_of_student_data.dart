import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class FirstSectionOfStudentData extends ConsumerWidget {
  const FirstSectionOfStudentData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstStudentData = ref.watch(firstStudentDataProvider);
    final userState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Nombre',
          initialValue: userState.user?.name,
          onChanged: ref.read(firstStudentDataProvider.notifier).onNameChanged,
          errorMessage: firstStudentData.isFormPosted
              ? firstStudentData.name.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Apellido',
          initialValue: userState.user?.lastName,
          errorMessage: firstStudentData.isFormPosted
              ? firstStudentData.lastName.errorMessage
              : null,
          onChanged:
              ref.read(firstStudentDataProvider.notifier).onLastNameChanged,
        ),
        CustomTextField(
          enabled: false,
          label: 'Matrícula',
          initialValue: userState.user?.id,
          errorMessage: firstStudentData.isFormPosted
              ? firstStudentData.studentEnrollment.errorMessage
              : null,
          onChanged: ref
              .read(firstStudentDataProvider.notifier)
              .onStudentEnrollmentChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Género',
          style: TextStyle(
              color: Color(0xff303030),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        const SelectGender(),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF989898),
                width: 1,
              )),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const SelectCareer();
                },
              );
            },
            trailing: const Icon(Icons.arrow_drop_down),
            title: const Text(
              'Programa académico',
            ),
            subtitle: Text(
              firstStudentData.career.value,
              style: const TextStyle(
                  color: Color(0xff5A4361), fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  ref.read(firstStudentDataProvider.notifier).onFormSubmit,
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

class SelectGender extends ConsumerWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstStudentData = ref.watch(firstStudentDataProvider);

    return SegmentedButton(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      segments: const [
        ButtonSegment(
            value: 'Masculino',
            label: Text('Masculino'),
            icon: Icon(Icons.male)),
        ButtonSegment(
            value: 'Femenino',
            label: Text('Femenino'),
            icon: Icon(Icons.female)),
      ],
      selected: {firstStudentData.gender.value},
      onSelectionChanged: (newSelection) {
        ref
            .read(firstStudentDataProvider.notifier)
            .onGenderChanged(newSelection.first.toString());
      },
    );
  }
}
