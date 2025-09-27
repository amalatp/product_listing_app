import 'package:product_listing_app/features/home/models/pduct_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': product.id,
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: ProductModel(
        id: map['productId'],
        title: map['title'],
        price: map['price'],
        image: map['image'],
      ),
      quantity: map['quantity'],
    );
  }
}
