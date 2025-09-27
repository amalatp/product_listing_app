import 'package:http/http.dart' as http;

class HomeDataProvider {
  Future<http.Response> getProductList() async {
    try {
      final res = http.get(Uri.parse('https://fakestoreapi.com/products'));
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
