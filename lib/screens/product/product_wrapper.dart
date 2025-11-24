import 'package:flutter/material.dart';
import 'package:myproject/screens/product/widget/product_screen.dart';
import '../../widget/bottom_nav_bar.dart';

class ProductsPageWrapper extends StatelessWidget {
  const ProductsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Products'),),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: SafeArea(
          child:  ProductsScreen(),
          ),
        );


  }
}
