import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    print('build');
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your orders'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState ==
                ConnectionState.waiting) //loading
              return Center(child: CircularProgressIndicator());
            if (dataSnapshot.hasError)
              return Center(
                child: Text('Error occured'),
              );
            return Consumer<Orders>(
              builder: (context, orderData, child) => ListView.builder(
                  itemBuilder: (_, index) => OrderItem(orderData.orders[index]),
                  itemCount: orderData.orders.length),
            );
          },
        ));
  }
}
