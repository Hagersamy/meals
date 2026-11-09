import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/router_generatin_config.dart';
import 'features/onboarding/onboarding_services/onboarding_sharedprefrences_sevice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OnboardingSharedPrefrencesService.initializeSharedPrefrencesStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: RouterGeneratinConfig.goRouter,
      ),
    );
  }
}
