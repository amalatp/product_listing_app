import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_elevated_button.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = context.mediaQueryHeight;
    final prodName = product.title ?? "-";
    final prodDescription = product.description ?? "--";
    final prodPrize = product.price ?? 0;
    final prodImage = product.image;
    final prodRating = product.rating?.rate ?? 0.0;
    final prodRatingCount = product.rating?.count ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(color: AppColors.tertiary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: prodImage ?? "",
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.broken_image, size: 80)),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(5),
                  height: height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.skeleton,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.highlight,
                        size: 12,
                      ),
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
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                prodName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(prodDescription, style: TextStyle()),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "₹${prodPrize.toStringAsFixed(2)}",
                style: TextStyle(
                  color: AppColors.highlight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DefaultElevatedButton(
                onTap: () {
                  final cartItem = CartItem(product: product, quantity: 1);
                  context.read<CartBloc>().add(AddToCart(cartItem));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item successfully added to your cart"),
                      backgroundColor: AppColors.highlight,
                    ),
                  );
                },
                buttonText: 'Add to Cart',
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
