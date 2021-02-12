import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (_, product, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).primaryColorLight,
                onPressed: () => product.toggleFavoriteStatus(),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).primaryColorLight,
              onPressed: () {
                cart.addItem(
                  product.id,
                  product.price,
                  product.title,
                );
                
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 1),
                    behavior: SnackBarBehavior.fixed,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
            backgroundColor: Colors.black87,
          ),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product.id,
        ),
      ),
    );
  }
}
