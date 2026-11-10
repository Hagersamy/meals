import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/app_database.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_style.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailsScreen({super.key, required this.meal});

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete meal?'),
        content: Text('"${meal.name}" will be removed permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await AppDatabase.instance.deleteMeal(meal.id);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final imageHeight = 320.h;
    final description = meal.description;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // StackFit.expand makes the stack fill the screen; without it the stack
      // only takes the image height and the details below get clipped.
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: meal.imageUrl.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: meal.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                  )
                : Image.asset(meal.imageUrl, fit: BoxFit.cover),
          ),
          Positioned(
            top: imageHeight - 30.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: ListView(
                padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
                children: [
                  Text(meal.name, style: AppTextStyle.homeTitleTextStyle),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      _InfoChip(icon: Icons.star, text: meal.rate.toString()),
                      SizedBox(width: 12.w),
                      _InfoChip(icon: Icons.access_time, text: meal.time),
                    ],
                  ),
                  SizedBox(height: 28.h),
                  Text('Description', style: AppTextStyle.black16Medium),
                  SizedBox(height: 10.h),
                  Text(
                    (description == null || description.isEmpty)
                        ? 'No description added for this meal.'
                        : description,
                    style: AppTextStyle.grey14Regular.copyWith(height: 1.6),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.grayColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Added on ${_formatDate(meal.createdAt)}',
                        style: AppTextStyle.grey14Regular,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Top buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CircleButton(
                      icon: Icons.arrow_back,
                      onTap: () => context.pop(),
                    ),
                    _CircleButton(
                      icon: Icons.delete_outline,
                      iconColor: Colors.red,
                      onTap: () => _confirmDelete(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryOrangeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryOrangeColor, size: 18.sp),
          SizedBox(width: 6.w),
          Text(
            text,
            style: AppTextStyle.black16Medium.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.blackColor,
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
