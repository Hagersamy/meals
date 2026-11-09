import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals/features/onboarding/widgets/onboarding_container_item.dart';

import '../../core/assets/app_assets.dart';
import '../../core/routing/app_routes.dart';
import 'onboarding_services/onboarding_sharedprefrences_sevice.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isFirstTime = OnboardingSharedPrefrencesService.isFirstTime();
      OnboardingSharedPrefrencesService.setFirstTimeWithFalse();
      if (isFirstTime == false) {
        context.pushReplacement(AppRoutes.homeScreen);
        OnboardingSharedPrefrencesService.setFirstTimeWithFalse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.onboardingImg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(bottom: 16.h, child: OnboardingContainerItem()),
        ],
      ),
    );
  }
}
