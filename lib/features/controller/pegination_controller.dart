import 'package:arcitech/features/home/services/allProductAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../home/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final _postRepository = postRepository();

  final List<Product> allProducts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  static int skip = 0;
  final int limit = 6;

  bool get isLoading => _isLoading;

  bool get hasMore => _hasMore;

  Future<void> fetchAllProducts() async {
    if (isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      List<Product> newProduct =
          (await _postRepository.fetchAllProduct(limit, skip)).cast<Product>();
      if (newProduct.isEmpty) {
        _hasMore = false;
      } else {
        allProducts.addAll(newProduct);
        skip = skip + 6;
      }
    } catch (e) {
      print("Error fetching post");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
