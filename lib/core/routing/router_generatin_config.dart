import 'package:go_router/go_router.dart';



import '../../features/home/home_screen.dart';
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
  //     GoRoute(
  //       name: AppRoutes.mealDetailsScreen,
  //       path: AppRoutes.mealDetailsScreen,
  //       builder: (context, state) => const SuccessScreen(),
  //     ),
  //     GoRoute(
  //       name: AppRoutes.addMealScreen,
  //       path: AppRoutes.addMealScreen,
  //       builder: (context, state) => const MainScreen(),
  //     )
    ],
  );
}
