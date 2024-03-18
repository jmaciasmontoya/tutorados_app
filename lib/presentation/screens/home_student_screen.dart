import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const SideMenu(),
      body: const HomeStudentView(),
    );
  }
}

class HomeStudentView extends ConsumerWidget {
  const HomeStudentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('¡Hola!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6F6F6F))),
            Text(
              '${userState.user?.name} ${userState.user?.lastName}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff303030)),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Tutorias',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303030)),
            ),
            const SizedBox(
              height: 20,
            ),
            const SectionTutoring(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Otros',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303030)),
            ),
            const SizedBox(
              height: 20,
            ),
            const SectionOthers(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTutoring extends ConsumerWidget {
  const SectionTutoring({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 390,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          const CardOption(
            title: 'Registro',
            description: 'Individual',
            icon: Icons.person,
          ),
          const CardOption(
            title: 'Registro',
            description: 'Grupal',
            icon: Icons.group,
          ),
          GestureDetector(
            onTap: () {
              context.push('/form');
            },
            child: const CardOption(
              title: 'Registro',
              description: 'Tutorados',
              icon: Icons.person_add_alt_1,
            ),
          ),
          const CardOption(
            title: 'Cronograma',
            description: 'Plan de acción tutorial',
            icon: Icons.calendar_month,
          ),
        ],
      ),
    );
  }
}

class SectionOthers extends StatelessWidget {
  const SectionOthers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: const [
          CardOption(
              title: 'Diagnostico',
              description: 'Test de aprendizaje',
              icon: Icons.checklist_rtl)
        ],
      ),
    );
  }
}
