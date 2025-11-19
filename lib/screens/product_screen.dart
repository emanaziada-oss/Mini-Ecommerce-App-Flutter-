import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product/products_cubit.dart';
import '../bloc/product/products_state.dart';
import '../core/data/datasources/api_service.dart';
import '../core/data/datasources/product_remote_data_source.dart';
import '../core/data/repositories/product_repository.dart';
import '../widget/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api =ApiService();
    final remote = ProductRemoteDataSource(api);
    final repo = ProductRepository(remote);

    return BlocProvider(
      create: (_) => ProductCubit(repo)..fetchProducts(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Products')),
          body: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                final products = state.products;
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final p = products[i];
                    return ProductCard(product: p);
                  },
                );
              } else if (state is ProductError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
