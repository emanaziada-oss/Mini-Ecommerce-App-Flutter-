// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../features/cart/cubit/cart_cubit.dart';
// import '../../features/fav/cubit/fav_cubit.dart';
// import '../../core/data/models/product_model.dart';
// import '../../features/cart/model/cart_model.dart';
// import '../../features/fav/model/fav_model.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   final ProductModel product;
//   const ProductDetailsScreen({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final favCubit = context.watch<FavCubit>();
//     final cartCubit = context.watch<CartCubit>();
//
//     final isFavorite = favCubit.isFavorite(product.id!);
//     final isInCart = cartCubit.contains(product.id!);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.title),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: isFavorite ? Colors.red : Colors.white,
//             ),
//             onPressed: () {
//               favCubit.toggleFavorite(
//                 FavItem(
//                   productId: product.id!,
//                   title: product.title,
//                   price: product.price ?? 0,
//                   rating: product.rating ?? 0,
//                   thumbnail: product.thumbnail ?? '',
//                   stock: product.stock!,
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   product.thumbnail,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             Text(
//               product.title,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//
//             Text(
//               "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
//               style: TextStyle(
//                   fontSize: 18, color: Color(0xFFFF6A77), fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//
//             Row(
//               children: List.generate(5, (index) {
//                 double rating = product.rating ?? 0;
//                 return Icon(
//                   index < rating.round() ? Icons.star : Icons.star_border,
//                   color: Colors.amber,
//                   size: 18,
//                 );
//               }),
//             ),
//             SizedBox(height: 16),
//
//             Text(
//               product.description ?? 'No description available.',
//               style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//             ),
//             SizedBox(height: 24),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: isInCart
//                     ? null
//                     : () {
//                   cartCubit.addToCart(
//                     CartItem(
//                       productId: product.id!,
//                       title: product.title,
//                       price: product.price ?? 0.0,
//                       quantity: 1,
//                       thumbnail: product.thumbnail ?? '',
//                       stock: product.stock ?? 0,
//                     ),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('${product.title} added to cart!'),
//                       duration: Duration(seconds: 1),
//                     ),
//                   );
//                 },
//                 icon: Icon(Icons.add_shopping_cart, color: Colors.white),
//                 label: Text(
//                   isInCart ? 'Added' : 'Add to Cart',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isInCart ? Colors.grey : Color(0xFFFF6A77),
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/screens/product/widget/build_review.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/fav/cubit/fav_cubit.dart';
import '../../core/data/models/product_model.dart';
import '../../features/cart/model/cart_model.dart';
import '../../features/fav/model/fav_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavCubit>();
    final cartCubit = context.watch<CartCubit>();
    final isInCart = context.select((CartCubit cubit) => cubit.contains(product.id!));

    final isFavorite = favCubit.isFavorite(product.id!);
    // final cartItem = cartCubit.getItem(product.id!); // Get existing cart item
    // final cartQuantity = cartItem?.quantity ?? 0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with back button and favorite
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, size: 20),
                            onPressed: () => Navigator.pop(context),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                            ),
                            onPressed: () {
                              favCubit.toggleFavorite(
                                FavItem(
                                  productId: product.id!,
                                  title: product.title,
                                  price: product.price ?? 0,
                                  rating: product.rating ?? 0,
                                  thumbnail: product.thumbnail ?? '',
                                  stock: product.stock!,
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Product Image
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image.network(
                          product.thumbnail,
                          height: 200,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 200,
                                color: Colors.grey[200],
                                child: Icon(Icons.image, size: 80, color: Colors.grey),
                              ),
                        ),
                      ),
                    ),

                    // Product Details Card
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Rating
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        product.rating.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Description
                            Text(
                              product.description!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 24),

                            // Price
                            Text(
                              '\$ ${product.price?.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 24),

                            // Reviews Header
                            Row(
                              children: [
                                Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '(${product.reviews.length})',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),


                            // Sample Review
                            //_buildReview(product),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 8,bottom: 8),
                                    itemCount: product.reviews.length,
                                  itemBuilder: (_,i)=> BuildReview(review: product.reviews[i]),
                                )

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Add to Cart Button
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isInCart
                    ? Colors.grey
                    : const Color(0xFFFF6A77),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child:  IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white, size: 25),
                  onPressed: () {

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('${product.title} added to cart!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    context.read<CartCubit>().addToCart(
                      CartItem(
                        productId: product.id!,
                        title: product.title,
                        price: product.price ?? 0.0,
                        quantity: 1,
                        thumbnail: product.thumbnail ?? '',
                        stock: product.stock ?? 0,
                      ),
                    );},
                  tooltip: 'Add to Cart',
                ),

              ),


          ],
        ),
      ),
    );
  }

  // Widget _buildReview(ProductModel product) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[50],
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             CircleAvatar(
  //               radius: 16,
  //               backgroundColor: Colors.grey[300],
  //               child: Icon(Icons.person, size: 20, color: Colors.grey[600]),
  //             ),
  //             SizedBox(width: 12),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'John Doe',
  //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  //                   ),
  //                   Text(
  //                     '2 weeks ago',
  //                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Row(
  //               children: List.generate(5, (index) {
  //                 return Icon(
  //                   index < 4 ? Icons.star : Icons.star_border,
  //                   color: Colors.amber,
  //                   size: 16,
  //                 );
  //               }),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           product.description!,
  //           style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.4),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
