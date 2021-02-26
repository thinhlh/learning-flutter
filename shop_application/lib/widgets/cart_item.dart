import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/cart.dart' as ci;

class CartItem extends StatelessWidget {
  /// An instance of an item in Cart
  final ci.CartItem cart;

  /// The id of the item in Cart, this is NOT the productId
  final String cartId;

  CartItem(this.cart, this.cartId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          Provider.of<Cart>(context, listen: false).removeItem(cartId),
      confirmDismiss: (action) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              )
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                    child: Text('\$${cart.price.toStringAsFixed(2)}')),
              ),
            ),
            title: Text(cart.title),
            subtitle: Text('Total: \$${(cart.price * cart.quantity)}'),
            trailing: Text('${cart.quantity.toString()} x'),
          ),
        ),
      ),
    );
  }
}
