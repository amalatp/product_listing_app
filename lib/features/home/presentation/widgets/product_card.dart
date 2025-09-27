import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/Routes/routes_name.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.width,
    required this.height,
  });
  final ProductModel product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(RoutesName.productDetails, arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [_productImage(), _rating()]),
          Text(
            product.title ?? "",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: height * 0.016,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "₹${product.price}",
            style: TextStyle(
              color: AppColors.highlight,
              fontSize: height * 0.016,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _rating() {
    return Positioned(
      bottom: 5,
      left: 5,
      child: Container(
        height: height * 0.03,
        width: height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.secondary.withValues(alpha: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.highlight, size: 12),
            const SizedBox(width: 4),
            Text(
              product.rating?.rate.toString() ?? "0",
              style: TextStyle(
                color: AppColors.highlight,
                fontSize: height * 0.012,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _productImage() {
    return Container(
      height: width * 0.48,
      decoration: BoxDecoration(
        color: AppColors.skeleton,
        borderRadius: BorderRadius.circular(12),
      ),
      child: (product.image != null && product.image!.isNotEmpty)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: product.image!.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported),
              ),
            )
          : const Icon(Icons.image_not_supported),
    );
  }
}
