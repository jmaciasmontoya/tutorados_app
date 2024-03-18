import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class MedicalDataSection extends ConsumerWidget {
  const MedicalDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Num. Seguro social',
          onChanged:
              ref.read(medicalDataProvider.notifier).onSocialNumberChanged,
          errorMessage: medicalProvider.isFormPosted
              ? medicalProvider.socialSecurityNumber.errorMessage
              : null,
        ),
        CustomTextField(
          label: 'Tipo de sangre',
          onChanged: ref.read(medicalDataProvider.notifier).onBloodTypeChanged,
          errorMessage: medicalProvider.isFormPosted
              ? medicalProvider.bloodType.errorMessage
              : null,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '¿Padeces alguna enfermedad?',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        const DiseaseOption(),
        medicalProvider.disease
            ? CustomTextField(
                label: '¿Cúal?',
                onChanged:
                    ref.read(medicalDataProvider.notifier).onDiseaseChanged,
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '¿Alérgico a algún medicamento y/o otro?',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        const AllergyOption(),
        medicalProvider.allergy
            ? CustomTextField(
                label: '¿Cúal?',
                onChanged:
                    ref.read(medicalDataProvider.notifier).onAllergyChanged,
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        const DisabilityOption(),
        const SizedBox(
          height: 10,
        ),
        const SubstanceOption(),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: medicalProvider.isPosting
                  ? null
                  : ref.read(medicalDataProvider.notifier).onFormSubmit,
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

class DiseaseOption extends ConsumerWidget {
  const DiseaseOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    return SegmentedButton(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      segments: const [
        ButtonSegment(value: false, label: Text('No')),
        ButtonSegment(value: true, label: Text('Sí')),
      ],
      selected: {medicalProvider.disease},
      onSelectionChanged: (newSelection) {
        ref
            .read(medicalDataProvider.notifier)
            .diseaseIsSelected(newSelection.first);
      },
    );
  }
}

class DisabilityOption extends ConsumerWidget {
  const DisabilityOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    return Container(
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
              return const Disability();
            },
          );
        },
        trailing: const Icon(Icons.arrow_drop_down),
        title: const Text(
          '¿Tienes alguna discapacidad?',
        ),
        subtitle: Text(
          medicalProvider.disability
              ? '${medicalProvider.disabilities.first}...'
              : 'Ninguna',
          style: const TextStyle(
              color: Color(0xff5A4361), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AllergyOption extends ConsumerWidget {
  const AllergyOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    return SegmentedButton(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      segments: const [
        ButtonSegment(value: false, label: Text('No')),
        ButtonSegment(value: true, label: Text('Sí')),
      ],
      selected: {medicalProvider.allergy},
      onSelectionChanged: (newSelection) {
        ref
            .read(medicalDataProvider.notifier)
            .allergyIsSelected(newSelection.first);
      },
    );
  }
}

class Disability extends ConsumerWidget {
  const Disability({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    const activeColor = Color(0xff5A4361);
    const selectedTileColor = Color(0xffE9DEF8);
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
            style: BorderStyle.solid, strokeAlign: 1, color: Colors.black38));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: ListView(
        children: [
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: !medicalProvider.disability,
              shape: shape,
              title: const Text('Ninguna'),
              value: !medicalProvider.disability,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).disabilityIsSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.visual,
              shape: shape,
              title: const Text('Visual'),
              value: medicalProvider.visual,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).visualSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.intellectual,
              shape: shape,
              title: const Text('Intelectual'),
              value: medicalProvider.intellectual,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).intellectualSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.auditory,
              shape: shape,
              title: const Text('Auditiva'),
              value: medicalProvider.auditory,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).auditorySelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.physical,
              shape: shape,
              title: const Text('Física/Motriz'),
              value: medicalProvider.physical,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).physicalSelected();
              }),
        ],
      ),
    );
  }
}

class SubstanceOption extends ConsumerWidget {
  const SubstanceOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    return Container(
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
              return const Substances();
            },
          );
        },
        trailing: const Icon(Icons.arrow_drop_down),
        title: const Text(
          '¿Consumes sustancias tóxicas?',
        ),
        subtitle: Text(
          medicalProvider.sustance
              ? '${medicalProvider.sustances.first}...'
              : 'Ninguna',
          style: const TextStyle(
              color: Color(0xff5A4361), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Substances extends ConsumerWidget {
  const Substances({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalProvider = ref.watch(medicalDataProvider);

    const activeColor = Color(0xff5A4361);
    const selectedTileColor = Color(0xffE9DEF8);
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
            style: BorderStyle.solid, strokeAlign: 1, color: Colors.black38));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: ListView(
        children: [
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: !medicalProvider.sustance,
              shape: shape,
              title: const Text('Ninguna'),
              value: !medicalProvider.sustance,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).sustancesIsSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.alcohol,
              shape: shape,
              title: const Text('Alcohol'),
              value: medicalProvider.alcohol,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).alcoholSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.cigar,
              shape: shape,
              title: const Text('Cigarro'),
              value: medicalProvider.cigar,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).cigarSelected();
              }),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              selected: medicalProvider.drugs,
              shape: shape,
              title: const Text('Drogas'),
              value: medicalProvider.drugs,
              onChanged: (newValue) {
                ref.read(medicalDataProvider.notifier).drugsSelected();
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
