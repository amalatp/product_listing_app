import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_app_bar.dart';
import 'package:product_listing_app/configs/components/default_elevated_button.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';
import 'package:product_listing_app/features/cart/presentation/widgets/cart_items.dart';
import 'package:product_listing_app/features/cart/presentation/widgets/total_amount_and_checkout_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(LoadCart());
    double width = context.mediaQueryWidth;
    double height = context.mediaQueryHeight;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "My Cart"),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    final cartItems = state.items;

                    if (cartItems.isEmpty) {
                      return const Center(child: Text('Your cart is empty'));
                    }

                    double totalPrice = 0;
                    for (var item in cartItems) {
                      totalPrice += (item.product.price ?? 0) * item.quantity;
                    }

                    return Column(
                      children: [
                        CartItems(
                          cartItems: cartItems,
                          width: width,
                          height: height,
                        ),
                        TotalAmountAndCheckoutButton(
                          height: height,
                          totalPrice: totalPrice,
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
