import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_application/tabs_screen.dart';

import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Venetus Shop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.purpleAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Lato',
        ),
        home: TabScreen(),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
        },
      ),
    );
  }
}
