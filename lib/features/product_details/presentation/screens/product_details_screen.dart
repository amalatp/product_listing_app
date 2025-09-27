import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_elevated_button.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';
import 'package:product_listing_app/features/product_details/presentation/widgets/product_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = context.mediaQueryHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(color: AppColors.tertiary),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetails(product: product, height: height),

              _addToCartButton(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  DefaultElevatedButton _addToCartButton(BuildContext context) {
    return DefaultElevatedButton(
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
    );
  }
}
