import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  ProductsGrid(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    final products = showFavorites
        ? Provider.of<Products>(context).favoriteProducts
        : Provider.of<Products>(context)
            .products; // return all products if shoFavorites is false

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        // this will attach listener to every product in products list, hence when the lists changes, it is automatically updated
        child: ProductItem(),
      ),
    );
  }
}
