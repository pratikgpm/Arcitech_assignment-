import 'package:arcitech/features/home/model/product_model.dart';
import 'package:arcitech/features/services/provider/searchProductAPIprovider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final searchNotifierProvider =
    NotifierProvider<searchNotifier, List<Product>>(() => searchNotifier());

class searchNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    // TODO: implement build
    return ([]);
  }

  void filterSearchProduct(String name) {
    List<Product> result = [];
    if (name.isNotEmpty) {
      final total = ref.read(searchProductAPIprovider);
      total.when(
        data: (data) {
          result = data
              .where((element) => element.title
                  .toString()
                  .toLowerCase()
                  .contains(name.toString().toLowerCase()))
              .toList();
          state = result;
        },
        error: (error, stackTrace) {},
        loading: () => null,
      );
    } else if (name.toString() == '') {
      state = [];
    }
  }
}
