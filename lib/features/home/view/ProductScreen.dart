import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/features/controller/pegination_controller.dart';
import 'package:arcitech/features/home/model/product_model.dart';
import 'package:arcitech/features/home/view/ProductDetailScreen.dart';
import 'package:arcitech/features/home/widgets/customToggleButtons.dart';
import 'package:arcitech/features/home/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  static router() => MaterialPageRoute(
        builder: (context) => const ProductScreen(),
      );

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> futureProducts;
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = ProductProvider();
    productProvider.fetchAllProducts();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 61,
          ),
          const Text(
            "Product",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 36,
          ),
          const Text(
            "Choice your Product",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Pallete.headingFontColr),
          ),
          const SizedBox(
            height: 13,
          ),
          SizedBox(
            width: 253,
            child: CustomToggleButtons(
              //its functionality can be implemented by using API sort path available on web
              buttonLabels: ['All', 'Popular', 'New'],
              onToggle: (index) {
                // Handle the toggle action here
                print("Button $index pressed");
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: SizedBox(
              child: ChangeNotifierProvider(
                create: (context) => productProvider..fetchAllProducts(),
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return NotificationListener(
                        onNotification: (ScrollNotification scrolInfo) {
                          if (scrolInfo.metrics.pixels ==
                                  scrolInfo.metrics.maxScrollExtent &&
                              !productProvider.isLoading) {
                            productProvider.fetchAllProducts();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: provider.allProducts.length +
                              (productProvider.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == productProvider.allProducts.length) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Pallete.regFontColr.withOpacity(0.5),
                              ));
                            }
                            final product = provider.allProducts[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                              product: product),
                                    ));
                              },
                              child: CustomProductCard(
                                brand: product.brand.toString().length > 1
                                    ? product.brand.toString()
                                    : product.category.toString(),
                                title: product.title ?? " ",
                                imageUrl: product.imageUrl ?? " ",
                                discount: product.discount.toString(),
                                price: product.price.toString(),
                              ),
                            );
                          },
                        ));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    ));
    ;
  }
}
