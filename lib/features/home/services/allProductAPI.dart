import 'dart:convert';
import 'package:arcitech/features/home/model/product_model.dart';
import 'package:http/http.dart' as http;

class postRepository {
  static const String _baseURL = 'https://dummyjson.com/products';

  Future<List<Product>> fetchAllProduct(int limit, int skip) async {
    final responce = await http.get(Uri.parse(
        '$_baseURL?limit=$limit&skip=$skip&select=id,title,brand,price,discountPercentage,images,category,description'));
    if (responce.statusCode == 200) {
      List<dynamic> jsonResponce = jsonDecode(responce.body)['products'];
      return jsonResponce.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }
}
