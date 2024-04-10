import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/auth_providers/auth_provider.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    final colors = Theme.of(context).colorScheme;
    return NavigationDrawer(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 300, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userState.user?.id}',
              style: TextStyle(
                  color: Color(colors.secondary.value),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${userState.user?.name} ${userState.user?.lastName}',
              style: TextStyle(
                  fontSize: 16, color: Color(colors.onSurface.value)),
            ),
            Text(
              '${userState.user?.email}',
              style: TextStyle(
                  fontSize: 16, color: Color(colors.onSurface.value)),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).logout();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Color(colors.primary.value),
              foregroundColor: Color(colors.onPrimary.value)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Salir',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    ]);
  }
}
