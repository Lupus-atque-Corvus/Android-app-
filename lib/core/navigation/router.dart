import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/preferences_provider.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/training/training_screen.dart';
import '../../features/training/active_workout_screen.dart';
import '../../features/training/exercise_library_screen.dart';
import '../../features/training/workout_detail_screen.dart';
import '../../features/training/exercise_progress_screen.dart';
import '../../features/health/health_screen.dart';
import '../../features/nutrition/nutrition_screen.dart';
import '../../features/nutrition/shopping_list_screen.dart';
import '../../features/nutrition/meal_log_screen.dart';
import '../../features/nutrition/food_search_screen.dart';
import '../../features/supplements/supplement_screen.dart';
import '../../features/planning/planning_screen.dart';
import '../../features/medication/medication_screen.dart';
import '../../features/abstinence/abstinence_screen.dart';
import '../../features/budget/budget_screen.dart';
import '../../features/budget/add_transaction_screen.dart';
import '../../features/budget/transaction_list_screen.dart';
import '../../features/budget/budget_stats_screen.dart';
import '../../features/budget/savings_screen.dart';
import '../../features/period_tracking/period_screen.dart';
import '../../features/period_tracking/period_calendar_screen.dart';
import '../../features/period_tracking/cycle_history_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/nav_settings_screen.dart';
import 'routes.dart';
import 'traum_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(preferencesRepositoryProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    redirect: (context, state) {
      final onboarded = prefs.onboardingComplete;
      final goingToOnboarding = state.matchedLocation == Routes.onboarding;
      if (!onboarded && !goingToOnboarding) return Routes.onboarding;
      if (onboarded && goingToOnboarding) return Routes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => TraumScaffold(
          location: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(path: Routes.home, builder: (_, __) => const HomeScreen()),

          // Training
          GoRoute(
            path: Routes.training,
            builder: (_, __) => const TrainingScreen(),
            routes: [
              GoRoute(path: 'active', builder: (_, __) => const ActiveWorkoutScreen()),
              GoRoute(path: 'exercises', builder: (_, __) => const ExerciseLibraryScreen()),
              GoRoute(
                path: 'session/:id',
                builder: (_, state) => WorkoutDetailScreen(
                  sessionId: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: 'exercise/:id/progress',
                builder: (_, state) => ExerciseProgressScreen(
                  exerciseId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),

          // Health
          GoRoute(path: Routes.health, builder: (_, __) => const HealthScreen()),

          // Nutrition
          GoRoute(
            path: Routes.nutrition,
            builder: (_, __) => const NutritionScreen(),
            routes: [
              GoRoute(path: 'shopping', builder: (_, __) => const ShoppingListScreen()),
              GoRoute(path: 'log', builder: (_, __) => const MealLogScreen()),
              GoRoute(path: 'search', builder: (_, __) => const FoodSearchScreen()),
            ],
          ),

          // Supplements
          GoRoute(path: Routes.supplements, builder: (_, __) => const SupplementScreen()),

          // Planning
          GoRoute(path: Routes.planning, builder: (_, __) => const PlanningScreen()),

          // Medication
          GoRoute(path: Routes.medication, builder: (_, __) => const MedicationScreen()),

          // Abstinence
          GoRoute(path: Routes.abstinence, builder: (_, __) => const AbstinenceScreen()),

          // Budget
          GoRoute(
            path: Routes.budget,
            builder: (_, __) => const BudgetScreen(),
            routes: [
              GoRoute(path: 'add', builder: (_, __) => const AddTransactionScreen()),
              GoRoute(path: 'transactions', builder: (_, __) => const TransactionListScreen()),
              GoRoute(path: 'stats', builder: (_, __) => const BudgetStatsScreen()),
              GoRoute(path: 'savings', builder: (_, __) => const SavingsScreen()),
            ],
          ),

          // Period
          GoRoute(
            path: Routes.period,
            builder: (_, __) => const PeriodScreen(),
            routes: [
              GoRoute(path: 'calendar', builder: (_, __) => const PeriodCalendarScreen()),
              GoRoute(path: 'history', builder: (_, __) => const CycleHistoryScreen()),
            ],
          ),

          // Settings
          GoRoute(
            path: Routes.settings,
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(path: 'nav', builder: (_, __) => const NavSettingsScreen()),
            ],
          ),
        ],
      ),
    ],
  );
});
