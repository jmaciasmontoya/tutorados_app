import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YesOrNoOption extends ConsumerWidget {
  
  final bool optionSelected = false;
  const YesOrNoOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


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
      selected: {optionSelected},
      onSelectionChanged: (newSelection) {
        print(newSelection);
      },
    );
  }
}

