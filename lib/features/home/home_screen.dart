import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals/core/styles/app_colors.dart';

import '../../core/assets/app_assets.dart';
import '../../core/database/app_database.dart';
import '../../core/routing/app_routes.dart';
import '../../core/styles/app_text_style.dart';
import 'widgets/food_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppAssets.homeImg,
                  width: double.infinity,
                  height: 300.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 32.w,
                  top: 80.h,
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome", style: AppTextStyle.onBoardingTextStyle),
                      Text(
                        "Add A New Recipe",
                        style: AppTextStyle.onBoardingTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Text(
                "Your Food",
                style: AppTextStyle.homeWelcomeTextStyle,
              ),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: StreamBuilder<List<Meal>>(
                stream: AppDatabase.instance.watchAllMeals(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final meals = snapshot.data!;
                  if (meals.isEmpty) {
                    return const Center(child: Text('No meals yet'));
                  }
                  return GridView.builder(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 16.h),
                    itemCount: meals.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      mainAxisExtent: 190.h,
                    ),
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return FoodItemWidget(
                        imgUrl: meal.imageUrl,
                        name: meal.name,
                        rate: meal.rate,
                        time: meal.time,
                        onTap: () => context.push(
                          AppRoutes.mealDetailsScreen,
                          extra: meal,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.addMealScreen),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryOrangeColor,
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 30.sp),
        ),
      ),
    );
  }
}
