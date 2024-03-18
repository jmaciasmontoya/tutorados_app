import 'package:flutter/material.dart';

class FormCompletedFeedback extends StatelessWidget {
  const FormCompletedFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('¡Gracias por completar el formulario!',
            style: TextStyle(
                color: Color(0xff5A4361),
                fontSize: 18,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
