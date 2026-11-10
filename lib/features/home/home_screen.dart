import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals/core/styles/app_colors.dart';

import '../../core/assets/app_assets.dart';
import '../../core/styles/app_text_style.dart';
import 'widgets/food_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sample data: replace with your real meals later.
  static const foods = [
    (name: "Vegetable Bowl", rate: 4.8, time: "20 min"),
    (name: "Chicken Salad", rate: 4.5, time: "15 min"),
    (name: "Pasta Primavera", rate: 4.6, time: "30 min"),
    (name: "Grilled Salmon", rate: 4.9, time: "25 min"),
    (name: "Beef Burger", rate: 4.3, time: "35 min"),
    (name: "Lentil Soup", rate: 4.7, time: "40 min"),
  ];

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
              child: GridView.builder(
                padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 16.h),
                itemCount: foods.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 190.h,
                ),
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return FoodItemWidget(
                    imgUrl: AppAssets.homeItemImg,
                    name: food.name,
                    rate: food.rate,
                    time: food.time,
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryOrangeColor,
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 30.sp),
        ),
      ),
    );
  }
}
