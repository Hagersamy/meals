import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals/core/styles/app_text_style.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/styles/app_colors.dart';



class OnboardingContainerItem extends StatefulWidget {
  const OnboardingContainerItem({super.key});

  @override
  State<OnboardingContainerItem> createState() =>
      _OnboardingContainerItemState();
}

class _OnboardingContainerItemState extends State<OnboardingContainerItem> {
  static const List<String> titles = [
    "Save Your Meals Ingredient",
    "Use Our App The Best Choice",
    " Our App Your Ultimate Choice",
  ];
  static const List<String> descriptions = [
    "Add Your Meals and its Ingredients and we will save it for you",
    "the best choice for your kitchen do not hesitate",
    "All the best restaurants and their top menus are ready for you",
  ];

  final CarouselSliderController carouselController =
      CarouselSliderController();
  double currentPage = 0;

  void goToHome() {
    context.go(AppRoutes.homeScreen);
  }

  void onNextPressed() {
    final isLastPage = currentPage >= titles.length - 1;
    if (isLastPage) {
      goToHome();
      return;
    }
    carouselController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311.w,
      height: 400.h,
      padding: EdgeInsets.all(32.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryOrangeColor.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(48.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: constraints.maxHeight,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() => currentPage = index.toDouble());
                    },
                  ),
                  items: List.generate(titles.length, (index) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Text(
                            titles[index],
                            style: AppTextStyle.onBoardingTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            descriptions[index],
                            style: AppTextStyle.onBoardingDescriptionTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          DotsIndicator(
            dotsCount: titles.length,
            position: currentPage,
            decorator: DotsDecorator(
              color: Colors.white.withValues(alpha: 0.5),
              activeColor: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: goToHome,
                child: Text(
                  "Skip",
                  style: AppTextStyle.onBoardingDescriptionTextStyle,
                ),
              ),
              TextButton(
                onPressed: onNextPressed,
                child: Text(
                  "Next",
                  style: AppTextStyle.onBoardingDescriptionTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
