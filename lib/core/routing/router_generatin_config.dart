import 'package:go_router/go_router.dart';



import '../../features/add_meal/add_meal_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/meal_details/meal_details_screen.dart';
import '../database/app_database.dart';
import '../../features/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

class RouterGeneratinConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.onBoardingScreen,
    routes: [
      GoRoute(
        name: AppRoutes.onBoardingScreen,
        path: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.mealDetailsScreen,
        path: AppRoutes.mealDetailsScreen,
        builder: (context, state) =>
            MealDetailsScreen(meal: state.extra as Meal),
      ),
      GoRoute(
        name: AppRoutes.addMealScreen,
        path: AppRoutes.addMealScreen,
        builder: (context, state) => const AddMealScreen(),
      ),
    ],
  );
}
