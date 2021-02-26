import 'package:flutter/material.dart';

import './screens/user_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_overview_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'screen': ProductOverviewScreen(), 'label': 'Aesthetic Shop'},
      {'screen': OrdersScreen(), 'label': 'Orders'},
      {'screen': UserProductsScreen(), 'label': 'User Products'},
    ];
    super.initState();
  }

  void _navigate(int index) {
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigate,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined),
            label: 'Manage Products',
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['screen'],
    );
  }
}
