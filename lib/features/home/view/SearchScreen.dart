import 'package:arcitech/features/home/widgets/customSearchField.dart';
import 'package:arcitech/features/home/widgets/productCard.dart';
import 'package:arcitech/features/services/provider/searchNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SearchScreen(),
      );

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchNotifierProvider);
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 48,
                child: CustomSearchField(
                  hintText: "Find Product",
                  onSearchBarHit: () {},
                  onChanged: (value) => ref
                      .read(searchNotifierProvider.notifier)
                      .filterSearchProduct(value),
                  onFilterPressed: () {},
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final product = searchResult[index];
                return CustomProductCard(
                    imageUrl: product.imageUrl.toString(),
                    title: product.title.toString(),
                    price: product.price.toString(),
                    discount: product.discount.toString(),
                    brand: product.brand.toString());
              },
            ))
          ],
        ),
      )),
    );
    ;
  }
}
