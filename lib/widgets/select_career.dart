import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/first_section_of_student_data_provider.dart';

class SelectCareer extends ConsumerWidget {
  const SelectCareer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstStudentData = ref.watch(firstStudentDataProvider);

    final borderShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
            style: BorderStyle.solid, strokeAlign: 1, color: Colors.black38));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ListView(
        children: [
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              selected: firstStudentData.career.value == 'Software',
              value: 'Software',
              title: const Text('Software'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Agroindustrial',
              selected: firstStudentData.career.value == 'Agroindustrial',
              title: const Text('Agroindustrial'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Ambiental',
              selected: firstStudentData.career.value == 'Ambiental',
              title: const Text('Ambiental'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Biomédica',
              selected: firstStudentData.career.value == 'Biomédica',
              title: const Text('Biomédica'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Energía',
              selected: firstStudentData.career.value == 'Energía',
              title: const Text('Energía'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Manufactura',
              selected: firstStudentData.career.value == 'Manufactura',
              title: const Text('Manufactura'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Mecatrónica',
              selected: firstStudentData.career.value == 'Mecatrónica',
              title: const Text('Mecatrónica'),
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Nanotecnología',
              title: const Text('Nanotecnología'),
              selected: firstStudentData.career.value == 'Nanotecnología',
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'Petrolera',
              title: const Text('Petrolera'),
              selected: firstStudentData.career.value == 'Petrolera',
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
              activeColor: const Color(0xff5A4361),
              selectedTileColor: const Color(0xffE9DEF8),
              shape: borderShape,
              value: 'LAGE',
              title: const Text('LAGE'),
              selected: firstStudentData.career.value == 'LAGE',
              groupValue: firstStudentData.career.value,
              onChanged: (newValue) {
                ref
                    .read(firstStudentDataProvider.notifier)
                    .onCareerChanged(newValue.toString());
              }),
        ],
      ),
    );
  }
}
