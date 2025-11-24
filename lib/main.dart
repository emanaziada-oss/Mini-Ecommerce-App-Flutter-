import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'bloc/auth/auth_cubit.dart';
import 'firebase_options.dart';

// Data & Repo
import 'core/data/datasources/api_service.dart';
import 'core/data/datasources/product_remote_data_source.dart';
import 'core/data/repositories/product_repository.dart';

// Cubits
import 'bloc/product/products_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/fav/cubit/fav_cubit.dart';

// Hive Models
import 'features/cart/model/cart_model.dart';
import 'features/fav/model/fav_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(FavItemAdapter());

  await Hive.deleteBoxFromDisk('cart');
  await Hive.deleteBoxFromDisk('fav');
  // Open Boxes
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<FavItem>('fav');

  final cartBox = Hive.box<CartItem>('cart');
  final favBox = Hive.box<FavItem>('fav');

  // Setup Repositories
  final api = ApiService();
  final remote = ProductRemoteDataSource(api);
  final repo = ProductRepository(remote);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => CartCubit(cartBox)..loadCart()),
        BlocProvider(create: (_) => FavCubit(favBox)..loadFavorites()),
        BlocProvider(create: (_) => ProductCubit(repo)..fetchProducts()),
      ],
      child: const MyApp(),
    ),
  );
}
