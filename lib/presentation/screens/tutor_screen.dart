import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/widgets/widgets.dart';

class TutorScreen extends StatelessWidget {
  const TutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const SideMenu(),
      body: const HomeTutorView(),
    );
  }
}

class HomeTutorView extends ConsumerWidget {
  const HomeTutorView({super.key});

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
            const SectionCards(),
          ],
        ),
      ),
    );
  }
}

class SectionCards extends StatelessWidget {
  const SectionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          GestureDetector(
            child: const CardOption(
              title: 'Mis tutorados',
              description: '...',
              icon: Icons.group,
            ),
            onTap: () {
              context.push('/tutored');
            },
          ),
        ],
      ),
    );
  }
}
