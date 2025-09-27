import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/Routes/routes_name.dart';
import 'package:product_listing_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';
import 'package:product_listing_app/features/home/presentation/screens/home_screen.dart';
import 'package:product_listing_app/features/product_details/presentation/screens/product_details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RoutesName.productDetails:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );

      case RoutesName.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
