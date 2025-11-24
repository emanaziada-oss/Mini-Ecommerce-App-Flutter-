import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/cart/cubit/cart_cubit.dart';
import '../../../features/cart/model/cart_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, size: 22),
                      onPressed: () {
                        final newQty = (item.quantity - 1).clamp(1, item.stock);
                        context.read<CartCubit>().updateQuantity(item.productId, newQty);
                      },
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, size: 22),
                      onPressed: () {
                        context.read<CartCubit>().updateQuantity(item.productId , item.quantity + 1);
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () => context.read<CartCubit>().removeFromCart(item.productId),
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
