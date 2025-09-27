import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .72,
        crossAxisSpacing: width * 0.04,
        mainAxisSpacing: height * 0.02,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.skeleton,
          highlightColor: AppColors.skeleton,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width * 0.48,
                decoration: BoxDecoration(
                  color: AppColors.skeleton,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: height * 0.02,
                width: width * 0.4,
                color: AppColors.skeleton,
              ),
              const SizedBox(height: 4),
              Container(
                height: height * 0.02,
                width: width * 0.2,
                color: AppColors.skeleton,
              ),
            ],
          ),
        );
      },
    );
  }
}
