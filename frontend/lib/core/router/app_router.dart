import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Placeholder screens for router
import '../../features/navigation/presentation/main_navigation_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/sports/presentation/sports_screen.dart';
import '../../features/workout/presentation/workout_session_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/timer/presentation/interval_timer_screen.dart';
import '../../features/ai_coach/presentation/ai_coach_screen.dart';
import '../../features/admin/presentation/admin_main_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/progress',
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
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
      GoRoute(
        path: '/timer',
        builder: (context, state) => const IntervalTimerScreen(),
      ),
      GoRoute(
        path: '/ai-coach',
        builder: (context, state) => const AiCoachScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminMainScreen(),
      ),
    ],
  );
});
