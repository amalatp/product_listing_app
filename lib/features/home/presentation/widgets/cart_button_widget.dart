import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesName.cart);
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int itemCount = 0;
          if (state is CartLoaded) {
            itemCount = state.items.length;
          }
          return SizedBox(
            height: height * 0.05,
            width: height * 0.05,
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: height * 0.04,
                    color: AppColors.tertiary,
                  ),
                ),
                if (itemCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: height * 0.02,
                      width: height * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          '$itemCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.011,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
