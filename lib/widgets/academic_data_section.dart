import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class AcademicDataSection extends ConsumerWidget {
  const AcademicDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academicProvider = ref.watch(academicDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Preparatoria de origen',
          errorMessage: (academicProvider.messageHighSchool != '')
              ? academicProvider.messageHighSchool
              : null,
          onChanged:
              ref.read(academicDataProvider.notifier).onHighSchoolChanged,
        ),
        CustomTextField(
          label: 'Promedio general',
          errorMessage: (academicProvider.messageAverage != '')
              ? academicProvider.messageAverage
              : null,
          keyboardType: TextInputType.number,
          onChanged: ref.read(academicDataProvider.notifier).onAverageChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Puntuación examen CENEVAL',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        CustomTextField(
          hint: 'Puntuación',
          errorMessage: (academicProvider.messageScore != '')
              ? academicProvider.messageScore
              : null,
          onChanged: ref.read(academicDataProvider.notifier).onScoreCeneval,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: academicProvider.isPosting
                  ? null
                  : ref.read(academicDataProvider.notifier).onFormSubmit,
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
