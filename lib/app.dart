import 'package:flutter/material.dart';
import 'package:myproject/screens/login_screen.dart';
import 'package:myproject/screens/product/product_wrapper.dart';
import 'package:myproject/screens/signup_screen.dart';
import 'package:myproject/screens/splash_screen.dart';
import 'package:myproject/screens/welcom_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Donut Delights',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // '/':(context)=>  TodoScreen(),
          // '/':(context)=>  TodoScreenProvider(),
          // '/': (context) => TodoScreengetx(),
          '/': (context) => const SplashScreen(),
          '/welcome' : (context) => const WelcomeScreen(),
          '/login' : (context)=> LoginForm(),
          '/signup' : (context)=>  SignupScreen(),
          '/products' : (context)=> const  ProductsPageWrapper(),
        },
      );

    }
  }
