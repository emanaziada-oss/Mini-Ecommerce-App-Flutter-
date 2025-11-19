import 'package:flutter/material.dart';
import '../core/data/models/product_model.dart';




class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 6,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: (p.thumbnail.isNotEmpty)
                      ? Image.network(
                    p.thumbnail,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white70,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${p.price?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(
                        color: Color(0xFFFF6A77),
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      double rating = p.rating ?? 0;
                      return Icon(
                        index < rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6A77),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${p.title} added to cart!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 18,color: Colors.white),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 13 , color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}