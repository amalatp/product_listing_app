import 'dart:convert';

import 'package:product_listing_app/features/home/data/data_provider/home_data_provider.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';

class HomeRepository {
  final HomeDataProvider homeDataProvider;
  HomeRepository(this.homeDataProvider);

  Future<List<ProductModel>> getProductList() async {
    try {
      final response = await homeDataProvider.getProductList();
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        List<ProductModel> products = jsonData
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        throw Exception("Failed to fetch product list: ${response.body}");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
