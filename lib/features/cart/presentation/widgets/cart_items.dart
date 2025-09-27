import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.cartItems,
    required this.width,
    required this.height,
  });

  final List<CartItem> cartItems;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final product = item.product;
          return _listTile(product, item, context);
        },
      ),
    );
  }

  ListTile _listTile(
    ProductModel product,
    CartItem item,
    BuildContext context,
  ) {
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
        style: TextStyle(fontSize: height * 0.015, color: AppColors.highlight),
      ),
      trailing: _addAndRemoveButtons(context, item),
    );
  }

  Row _addAndRemoveButtons(BuildContext context, CartItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            context.read<CartBloc>().add(RemoveFromCart(item));
          },
        ),
        Text(item.quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            context.read<CartBloc>().add(AddToCart(item));
          },
        ),
      ],
    );
  }
}
