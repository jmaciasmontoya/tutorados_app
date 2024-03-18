import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/form_providers/socieconomic_data_provider.dart';
import 'package:tutorados_app/widgets/custom_text_field.dart';

class SocioeconomicDataSection extends ConsumerWidget {
  const SocioeconomicDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socioeconomicProvider = ref.watch(socioeconomicDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Actualmente trabajas?',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        const WorkOption(),
        socioeconomicProvider.work
            ? CustomTextField(
                label: '¿Dónde?',
                onChanged: ref
                    .read(socioeconomicDataProvider.notifier)
                    .onWorkplaceChanged,
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '¿Cuenta con apoyo económico para sus estudios?',
          style: TextStyle(
              color: Color(0xff5A4361),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        const EconomicalSupportOption(),
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
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const Coexistence();
                },
              );
            },
            trailing: const Icon(Icons.arrow_drop_down),
            title: const Text(
              '¿Con quién vives actualmente?',
            ),
            subtitle: Text(
              socioeconomicProvider.livesWith,
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
              onPressed: socioeconomicProvider.isPosting
                  ? null
                  : ref.read(socioeconomicDataProvider.notifier).onFormSubmit,
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

class WorkOption extends ConsumerWidget {
  const WorkOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socioeconomicProvider = ref.watch(socioeconomicDataProvider);

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
      selected: {socioeconomicProvider.work},
      onSelectionChanged: (newSelection) {
        ref
            .read(socioeconomicDataProvider.notifier)
            .onOptionWorkChanged(newSelection.first);
      },
    );
  }
}

class EconomicalSupportOption extends ConsumerWidget {
  const EconomicalSupportOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socioeconomicProvider = ref.watch(socioeconomicDataProvider);

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
      selected: {socioeconomicProvider.economicalSupport},
      onSelectionChanged: (newSelection) {
        ref
            .read(socioeconomicDataProvider.notifier)
            .onEconomicalSupportOptionChanged(newSelection.first);
      },
    );
  }
}

class Coexistence extends ConsumerWidget {
  const Coexistence({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socioeconomicProvider = ref.watch(socioeconomicDataProvider);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const activeColor = Color(0xff5A4361);
    const selectedTileColor = Color(0xffE9DEF8);
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
            style: BorderStyle.solid, strokeAlign: 1, color: Colors.black38));

    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                selected: socioeconomicProvider.livesWith == 'Solo',
                activeColor: activeColor,
                selectedTileColor: selectedTileColor,
                shape: shape,
                value: 'Solo',
                title: const Text('Solo'),
                groupValue: socioeconomicProvider.livesWith,
                onChanged: (newValue) {
                  ref
                      .read(socioeconomicDataProvider.notifier)
                      .onLiveWithChanged(newValue.toString());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                  selected: socioeconomicProvider.livesWith == 'Padres',
                  activeColor: activeColor,
                  selectedTileColor: selectedTileColor,
                  shape: shape,
                  value: 'Padres',
                  title: const Text('Padres'),
                  groupValue: socioeconomicProvider.livesWith,
                  onChanged: (newValue) {
                    ref
                        .read(socioeconomicDataProvider.notifier)
                        .onLiveWithChanged(newValue.toString());
                  }),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                  selected: socioeconomicProvider.livesWith == 'Amigos',
                  activeColor: activeColor,
                  selectedTileColor: selectedTileColor,
                  shape: shape,
                  value: 'Amigos',
                  title: const Text('Amigos'),
                  groupValue: socioeconomicProvider.livesWith,
                  onChanged: (newValue) {
                    ref
                        .read(socioeconomicDataProvider.notifier)
                        .onLiveWithChanged(newValue.toString());
                  }),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                  selected:
                      socioeconomicProvider.livesWith == 'Uno de sus padres',
                  activeColor: activeColor,
                  selectedTileColor: selectedTileColor,
                  shape: shape,
                  value: 'Uno de sus padres',
                  title: const Text('Uno de sus padres'),
                  groupValue: socioeconomicProvider.livesWith,
                  onChanged: (newValue) {
                    ref
                        .read(socioeconomicDataProvider.notifier)
                        .onLiveWithChanged(newValue.toString());
                  }),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                  selected: socioeconomicProvider.livesWith == 'Pareja',
                  activeColor: activeColor,
                  selectedTileColor: selectedTileColor,
                  shape: shape,
                  value: 'Pareja',
                  title: const Text('Pareja'),
                  groupValue: socioeconomicProvider.livesWith,
                  onChanged: (newValue) {
                    ref
                        .read(socioeconomicDataProvider.notifier)
                        .onLiveWithChanged(newValue.toString());
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                label: 'Otros, especifique',
                onChanged: ref
                    .read(socioeconomicDataProvider.notifier)
                    .onAnotherOption,
                controller:
                    ref.read(socioeconomicDataProvider.notifier).anotherOption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
