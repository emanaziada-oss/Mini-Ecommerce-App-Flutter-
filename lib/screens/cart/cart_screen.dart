import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/cart/cubit/cart_state.dart';
import '../../features/cart/model/cart_model.dart';
import '../../widget/bottom_nav_bar.dart';
import 'widget/cart_item_tile.dart';
import 'package:hive/hive.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CartCubit>().loadCart();
    });
  }
  @override
  Widget build(BuildContext context) {
    final cartBox = Hive.box<CartItem>('cart');

    return Scaffold(
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
        appBar: AppBar(
          title: Text(
            'Your Cart',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              // Show loading indicator on first load
              if (state is CartInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              // When items are loaded
              else if (state is CartLoaded) {
                if (state.items.isEmpty) {
                  return const Center(child: Text('Cart is empty'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        itemCount: state.items.length,
                        itemBuilder: (_, i) => CartItemTile(item: state.items[i]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, -2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sub Total:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFACA9A7)),
                              ),
                              Text(
                                '\$${state.total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFACA9A7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Charges:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFACA9A7)),
                              ),
                              Text(
                                '\$4.00',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFACA9A7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ]
                          ),
                          SizedBox(height: 14),
                          Divider(color: Color(0xFFACA9A7)),
                          SizedBox(height: 14),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,)
                                ),
                                Text(
                                  '\$${(state.total+4.00).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFFF6A77),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.payment, size: 18,color: Colors.white),
                                  label: Text('Checkout',
                                      style: TextStyle(fontSize: 14, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF6A77),
                                    padding:
                                    EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      context.read<CartCubit>().clearCart(),
                                  icon: Icon(Icons.delete_forever, size: 18,color: Color(0xFFFF6A77)),
                                  label: Text('Clear Cart',
                                      style: TextStyle(fontSize: 14, color: Color(0xFFFF6A77))),
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ],
                );
              }
              // Default fallback
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    // );
  }
}
