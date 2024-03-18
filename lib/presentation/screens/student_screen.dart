import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';

class StudentScreen extends StatelessWidget {
  final String studentId;

  const StudentScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StudentView(
        studentId: studentId,
      ),
    );
  }
}

class StudentView extends ConsumerWidget {
  final String studentId;
  const StudentView({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentState = ref.watch(studentProvider(studentId));
    return studentState.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderContainer(
                    studentId: studentState.id,
                    name: studentState.student?.name?? 'nombre',
                    lastName: studentState.student?.lastName?? 'apellido',
                    career: studentState.student?.career?? 'carrera',
                    email: '203422@ids.upchiapas.edu.mx',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Datos del alumno',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403046)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const StudentData(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Contacto',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403046)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ContactData(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Datos médicos',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403046)),
                  ),
                  const MedicalData(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Datos acádemicos',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403046)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AcademicData(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Datos socioeconomicos',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403046)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SocioEconomicData(),
                ],
              ),
            ),
          );
  }
}

class HeaderContainer extends StatelessWidget {
  final String studentId;
  final String name;
  final String lastName;
  final String career;
  final String email;
  const HeaderContainer(
      {super.key,
      required this.studentId,
      required this.name,
      required this.lastName,
      required this.career,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff80608B),
                borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.person, color: Colors.white, size: 70),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            studentId,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff403046),
                fontWeight: FontWeight.w500),
          ),
          Text(
            '$name $lastName',
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff403046),
                fontWeight: FontWeight.w700),
          ),
          Text(career,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff403046),
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}

class StudentData extends StatelessWidget {
  const StudentData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Edad'),
        Text('Género'),
        Text('Religión'),
        Text('Actividad deportiva'),
        Text('Fecha de nacimiento'),
        Text('Lugar de nacimiento'),
        Text('Tutor o Padre de familia'),
      ],
    );
  }
}

class ContactData extends StatelessWidget {
  const ContactData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Celular'),
        Text('Tel. Casa'),
        Text('Correo'),
        Text('Correo del tutor'),
        Text('Domicilio actual'),
        Text('Domicilio Familiar'),
      ],
    );
  }
}

class MedicalData extends StatelessWidget {
  const MedicalData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Número de Seguro social'),
        Text('Tipo de sangre'),
        Text('¿Padece algúna enfermedad?'),
        Text('¿Padece algúna discapacidad?'),
        Text('¿Padece algúna alergía?'),
        Text('¿Consume algúna sustancia?'),
      ],
    );
  }
}

class AcademicData extends StatelessWidget {
  const AcademicData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preparatoria de origen'),
        Text('Promedio'),
        Text('Puntuación de examen CENEVAL'),
      ],
    );
  }
}

class SocioEconomicData extends StatelessWidget {
  const SocioEconomicData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trabajo actual'),
        Text('¿Cuenta con apoyo económico?'),
        Text('Vive con: '),
      ],
    );
  }
}
