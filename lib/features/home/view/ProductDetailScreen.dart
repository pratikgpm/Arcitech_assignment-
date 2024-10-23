import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/core/widgets/customButton.dart';
import 'package:arcitech/features/controller/FavoriteController.dart';
import 'package:arcitech/features/home/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favProvider = ref.watch(FavoriteProductNotifierProvider);
    bool isFavorite = favProvider.contains(product);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                height: 350,
                child: Image.network(product.imageUrl.toString()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title.toString(),
                        style: const TextStyle(
                            color: Pallete.headingFontColr,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        product.brand.toString(),
                        style: const TextStyle(
                            color: Pallete.regFontColr,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      ref
                              .read(FavoriteProductNotifierProvider.notifier)
                              .isFavorite(product)
                          ? ref
                              .read(FavoriteProductNotifierProvider.notifier)
                              .remoreProduct(product)
                          : ref
                              .read(FavoriteProductNotifierProvider.notifier)
                              .addProduct(product);
                    },
                    icon: ref
                            .read(FavoriteProductNotifierProvider.notifier)
                            .isFavorite(product)
                        ? const Icon(
                            size: 26,
                            CupertinoIcons.heart_fill,
                            color: Pallete.red,
                          )
                        : const Icon(
                            size: 26,
                            CupertinoIcons.heart,
                            color: Pallete.regFontColr,
                          ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                      color: Pallete.bgBlue,
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFFEBF0)),
                  child: Text(
                    '${product.discount}% off',
                    style: const TextStyle(
                        color: Pallete.orange,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 10,
                )),
                Container(
                  child: Flexible(
                    child: customButton(
                      isInverse: true,
                      title: "Buy",
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              product.description.toString(),
              style: const TextStyle(fontSize: 16, color: Pallete.regFontColr),
            ),
          ],
        ),
      ),
    );
  }
}
