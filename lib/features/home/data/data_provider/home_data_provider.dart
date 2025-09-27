import 'package:http/http.dart' as http;

class HomeDataProvider {
  Future<http.Response> getProductList() async {
    try {
      final res = http.get(
        Uri.parse('https://fakestoreapi.com/products'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
