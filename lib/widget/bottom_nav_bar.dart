import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/fav/fav_screen.dart';
import '../screens/product/product_wrapper.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);
final int currentIndex ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return CircleNavBar(
      activeIcons: [
        Icon(Icons.shopping_cart, color: colorScheme.onPrimary),
        Icon(Icons.home, color: colorScheme.onPrimary),
        Icon(Icons.favorite, color: colorScheme.onPrimary),
      ],
      inactiveIcons: const [
        Text("Cart", style: TextStyle(color:  Colors.black )),
        Text("Home", style: TextStyle(color:  Colors.black )),
        Text("Favorite", style: TextStyle(color:  Colors.black)),
      ],

      //  Colors that change with theme
      circleColor: colorScheme.primary, // main circle color from theme
      color: colorScheme.onPrimary, // bar background

      //  Visual adjustments
      height: 60,
      circleWidth: 60,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      cornerRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      shadowColor: isDark ? Colors.white24 : Colors.black26,
      circleShadowColor: isDark ? Colors.white38 : Colors.black38,
      elevation: 2,

      //  Active tab index (you can manage this in a StatefulWidget)
      activeIndex: currentIndex,

      //  Navigation logic
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProductsPageWrapper()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FavPage()),
            );
            break;
        }
      },
    );

  }
}
