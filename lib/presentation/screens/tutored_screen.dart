import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/config/config.dart';
import 'package:tutorados_app/presentation/delegates/search_student.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';

class TutoredScreen extends ConsumerWidget {
  const TutoredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final studentSearch = ref.read(searchStudentProvider.notifier);
              showSearch<dynamic>(
                  context: context,
                  delegate: SearchStudent(
                      searchStudent: (query) =>
                          studentSearch.searchStudents(query))).then((student) {
                if (student == null) return;
                context.push('/student/${student['usuario_id']}');
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const TutoredView(),
    );
  }
}

class TutoredView extends ConsumerWidget {
  const TutoredView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutoredState = ref.watch(tutoredProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mis tutorados',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff403046))),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: TutoredSection(
            students: tutoredState.students,
          ))
        ],
      ),
    );
  }
}

class TutoredSection extends ConsumerWidget {
  final List students;
  const TutoredSection({super.key, required this.students});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(tutoredProvider.notifier).loadNextPage();
      }
    });
    return students.isEmpty
        ? const Center(
            child: Text('No hay alumnos registrados'),
          )
        : ListView.builder(
            controller: scrollController,
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return GestureDetector(
                onTap: () => context.push('/student/${student['alumno_id']}'),
                child: CardTutored(
                  studentEnrollment: student['alumno_id'],
                  name: student['nombre'],
                  lastName: student['apellido'],
                  email: student['correo'],
                  image: student['imagen'],
                ),
              );
            },
          );
  }
}

class CardTutored extends StatelessWidget {
  final String studentEnrollment;
  final String name;
  final String lastName;
  final String email;
  final String image;

  const CardTutored(
      {super.key,
      required this.studentEnrollment,
      required this.name,
      required this.lastName,
      required this.email,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studentEnrollment,
                style: const TextStyle(
                    color: Color(0xff303030), fontWeight: FontWeight.w500),
              ),
              Text(
                '$name $lastName',
              ),
              Text(
                email,
              ),
            ],
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: ImageViewer(image: image),
          )
        ],
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String image;
  const ImageViewer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FadeInImage(
        fit: BoxFit.cover,
        image: NetworkImage('${Environment.apiUrl}/$image'),
        placeholder: const AssetImage('assets/loaders/loading.gif'),
      ),
    );
  }
}
