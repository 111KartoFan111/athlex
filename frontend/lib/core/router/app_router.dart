import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Placeholder screens for router
import '../../features/navigation/presentation/main_navigation_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/sports/presentation/sports_screen.dart';
import '../../features/workout/presentation/workout_session_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sports',
                builder: (context, state) => const SportsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/workout/:id',
        builder: (context, state) {
          final workoutId = state.pathParameters['id'] ?? '';
          return WorkoutSessionScreen(workoutId: workoutId);
        },
      ),
    ],
  );
});
