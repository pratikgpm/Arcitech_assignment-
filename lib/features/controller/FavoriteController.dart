import 'package:arcitech/features/home/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FavoriteProductNotifierProvider =
    NotifierProvider<FavoriteProductNotifier, List<Product>>(() {
  return FavoriteProductNotifier();
});

class FavoriteProductNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    // TODO: implement build
    return ([]);
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void remoreProduct(Product product) {
    state = state.where((prod) => prod.id != product.id).toList();
  }

  bool isFavorite(Product product) {
    return state.any((element) => element.id == product.id);
  }

  void ToggleFavorite(Product product) {
    if (state.contains(product)) {
      state.remove(product);
    } else {
      state.add(product);
    }
  }
}
