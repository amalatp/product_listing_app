import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_elevated_button.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';

class TotalAmountAndCheckoutButton extends StatelessWidget {
  const TotalAmountAndCheckoutButton({
    super.key,
    required this.height,
    required this.totalPrice,
  });

  final double height;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
