import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_text_style.dart';

class FoodItemWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final double rate;
  final String time;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const FoodItemWidget({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.rate,
    required this.time,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        child: Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Web links load from the internet, anything else is a local asset.
              if (imgUrl.startsWith('http'))
                CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  width: 137.w,
                  height: 106.h,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                )
              else
                Image.asset(
                  imgUrl,
                  fit: BoxFit.cover,
                  width: 137.w,
                  height: 106.h,
                ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 120.w,
                child: Text(
                  name,
                  maxLines: 1,
                  style: AppTextStyle.black16Medium,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.primaryOrangeColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        rate.toString(),
                        style: AppTextStyle.grey14Regular.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.lock_clock,
                        color: AppColors.primaryOrangeColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        time.toString(),
                        style: AppTextStyle.grey14Regular.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
