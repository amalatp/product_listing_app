import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';

class ImageAndRatingWidget extends StatelessWidget {
  const ImageAndRatingWidget({
    super.key,
    required this.prodImage,
    required this.height,
    required this.prodRating,
    required this.prodRatingCount,
  });

  final String? prodImage;
  final double height;
  final double prodRating;
  final int prodRatingCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CachedNetworkImage(
          imageUrl: prodImage ?? "",
          fit: BoxFit.contain,
          placeholder: (context, url) => const Center(child: SizedBox()),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.broken_image, size: 80)),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          height: height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.skeleton.withValues(alpha: 0.9),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: AppColors.highlight, size: 12),
              const SizedBox(width: 4),
              Text(
                prodRating.toStringAsFixed(1),
                style: TextStyle(
                  color: AppColors.highlight,
                  fontSize: height * 0.012,
                  fontWeight: FontWeight.w600,
                ),
              ),
              VerticalDivider(),
              Text(
                "$prodRatingCount Ratings",
                style: TextStyle(
                  color: AppColors.highlight,
                  fontSize: height * 0.012,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
