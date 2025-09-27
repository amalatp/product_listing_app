import 'dart:convert';
import 'package:product_listing_app/features/home/models/pduct_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }

  static String encode(List<CartItem> items) => jsonEncode(
    items.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
  );

  static List<CartItem> decode(String items) =>
      (jsonDecode(items) as List<dynamic>)
          .map<CartItem>((item) => CartItem.fromJson(item))
          .toList();
}
