import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/features/controller/FavoriteController.dart';
import 'package:arcitech/features/home/view/ProductDetailScreen.dart';
import 'package:arcitech/features/home/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favList = ref.watch(FavoriteProductNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Favorite Product",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Pallete.whiteColor,
      ),
      body: favList.isEmpty
          ? const Center(child: Text("No favorite items here "))
          : ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final product = favList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(product: product),
                        ));
                  },
                  child: CustomProductCard(
                    title: product.title.toString(),
                    brand: product.brand.toString(),
                    imageUrl: product.imageUrl.toString(),
                    discount: product.discount.toString(),
                    price: product.price.toString(),
                  ),
                );
              },
            ),
    );
  }
}
