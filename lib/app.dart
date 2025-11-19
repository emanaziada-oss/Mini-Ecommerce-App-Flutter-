import 'package:flutter/material.dart';
import 'package:myproject/bloc/product/products_cubit.dart';
import 'package:myproject/bloc/product/products_state.dart';
import 'package:myproject/core/data/datasources/api_service.dart';
import 'package:myproject/core/data/datasources/product_remote_data_source.dart';
import 'package:myproject/core/data/repositories/product_repository.dart';
import 'package:myproject/getx/todo_getx_screen.dart';
import 'package:myproject/provider_todo/todo_provider_screen.dart';
import 'package:myproject/screens/login_screen.dart';
import 'package:myproject/screens/product_screen.dart';
import 'package:myproject/screens/signup_screen.dart';
import 'package:myproject/screens/splash_screen.dart';
import 'package:myproject/screens/todo_screen.dart';
import 'package:myproject/screens/welcom_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final api =ApiService();
    final remote = ProductRemoteDataSource(api);
    final repo = ProductRepository(remote);

    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (_)=> ProductCubit(repo) ..fetchProducts()
        ),
      ],
          child: BlocBuilder <ProductCubit,ProductState>(
        builder: (context,state){
        return MaterialApp(
        title: 'Donut Delights',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // '/':(context)=>  TodoScreen(),
          // '/':(context)=>  TodoScreenProvider(),
          // '/': (context) => TodoScreengetx(),
          '/': (context) => const SplashScreen(),
          '/welcom' : (context) => const WelcomeScreen(),
          '/login' : (context)=> LoginForm(),
          '/signup' : (context)=>  SignupScreen(),
          '/products' : (context)=>  ProductsScreen(),
        },
      );

    }),
    );
  }
}