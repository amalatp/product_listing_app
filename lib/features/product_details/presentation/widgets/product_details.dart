import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';
import 'package:product_listing_app/features/product_details/presentation/widgets/image_and_rating_widget.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
    required this.height,
  });

  final ProductModel product;
  final double height;

  @override
  Widget build(BuildContext context) {
    final prodName = product.title ?? "-";
    final prodDescription = product.description ?? "--";
    final prodPrize = product.price ?? 0;
    final prodImage = product.image;
    final prodRating = product.rating?.rate ?? 0.0;
    final prodRatingCount = product.rating?.count ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageAndRatingWidget(
          prodImage: prodImage,
          height: height,
          prodRating: prodRating,
          prodRatingCount: prodRatingCount,
        ),
        const SizedBox(height: 16),
        Text(
          prodName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(prodDescription, style: TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        Text(
          "₹${prodPrize.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.highlight,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
