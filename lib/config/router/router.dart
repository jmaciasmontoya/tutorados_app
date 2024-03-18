import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorados_app/config/router/app_router_notifier.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeStudentScreen(),
      ),
      GoRoute(
        path: '/form',
        builder: (context, state) => const FormScreen(),
      ),
      GoRoute(
        path: '/tutor',
        builder: (context, state) => const TutorScreen(),
      ),
      GoRoute(
        path: '/tutored',
        builder: (context, state) => const TutoredScreen(),
      ),
      GoRoute(
        path: '/student/:id',
        builder: (context, state) => StudentScreen(
          studentId: state.pathParameters['id'] ?? 'No id',
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final user = goRouterNotifier.user;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/home';
        }

        if (user != null && user.role == 'Tutor') {
          if (isGoingTo == '/tutored') {
            return null;
          }

          if (isGoingTo.startsWith('/student')) {
            return isGoingTo;
          }

          return '/tutor';
        }
      }

      return null;
    },
  );
});
