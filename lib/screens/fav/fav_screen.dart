import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/screens/fav/widget/fav_item.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/fav/cubit/fav_cubit.dart';
import '../../features/fav/cubit/fav_state.dart';
import '../../widget/bottom_nav_bar.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  void initState() {
    super.initState();
      context.read<CartCubit>().loadCart();
  }
  Widget build(BuildContext context) {


    return Scaffold(
          bottomNavigationBar: const BottomNavBar(currentIndex: 2),
          appBar: AppBar(
            title: Text(
              'Your favourite ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: BlocBuilder<FavCubit, FavState>(
              builder: (context, state) {
                // Show loading indicator on first load
                if (state is FavoritesInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                // When items are loaded
                else if (state is FavoritesLoaded) {
                  if (state.items.isEmpty) {
                    return const Center(child: Text('Favourite is empty'));
                  }

                  return Column(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           children:[
                             Spacer(),
                             OutlinedButton.icon(
                              onPressed: () =>
                                  context.read<FavCubit>().clearFavorites(),
                              icon: Icon(Icons.delete_forever, size: 18,color: Color(0xFFFF6A77)),
                              label: Text('Clear Favourites',
                                  style: TextStyle(fontSize: 14, color: Color(0xFFFF6A77))),
                              style: OutlinedButton.styleFrom(
                                padding:
                                EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            ]
                         ),
                       ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          itemCount: state.items.length,
                          itemBuilder: (_, i) => FavItemTile(item: state.items[i]),
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

  }
}
