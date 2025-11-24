import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/features/fav/model/fav_model.dart';
import '../../../features/cart/cubit/cart_cubit.dart';
import '../../../features/fav/cubit/fav_cubit.dart';

class FavItemTile extends StatelessWidget {
  final FavItem item;

  const FavItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();

    // Check states
    final isInCart = context.select((CartCubit cubit) => cubit.contains(item.productId));

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.thumbnail,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Color(0xFFFF6A77),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isInCart
                  ? Colors.grey
                  : const Color(0xFFFF6A77),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('${item.title} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                context.read<CartCubit>().addFavToCart(item);},
              tooltip: 'Add to Cart',
            ),
          ),
          SizedBox(height: 8),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
            onPressed: () => context.read<FavCubit>().removeFavorite(item.productId),
            tooltip: 'Remove',
          ),
        ],
      ),


          ],
        ),
      ),
    );
  }
}
