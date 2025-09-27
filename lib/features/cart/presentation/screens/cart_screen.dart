import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_app_bar.dart';
import 'package:product_listing_app/configs/components/default_elevated_button.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';

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
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: cartItems.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              final product = item.product;
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: product.image ?? "",
                                  width: width * 0.15,
                                  height: width * 0.3,
                                  fit: BoxFit.contain,
                                ),
                                title: Text(
                                  product.title ?? "",
                                  style: TextStyle(fontSize: height * 0.015),
                                ),
                                subtitle: Text(
                                  '₹${product.price} x ${item.quantity}',
                                  style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: AppColors.highlight,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          RemoveFromCart(item),
                                        );
                                      },
                                    ),
                                    Text(item.quantity.toString()),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          AddToCart(item),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '₹${totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: height * 0.023,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              DefaultElevatedButton(
                                onTap: () {
                                  context.read<CartBloc>().add(ClearCart());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppColors.highlight,
                                      content: Text('Checkout successful!'),
                                    ),
                                  );
                                },
                                buttonText: 'Checkout',
                              ),
                            ],
                          ),
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
