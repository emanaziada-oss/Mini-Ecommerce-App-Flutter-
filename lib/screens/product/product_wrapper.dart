// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myproject/bloc/auth/auth_cubit.dart';
// import 'package:myproject/screens/product/widget/product_screen.dart';
// import '../../bloc/auth/auth_state.dart';
// import '../../widget/bottom_nav_bar.dart';
// import '../login_screen.dart';
//
// class ProductsPageWrapper extends StatelessWidget {
//   const ProductsPageWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Products',style: TextStyle(fontWeight: FontWeight.bold)),
//           actions: [IconButton(
//               onPressed: (){
//                 context.read<AuthCubit>().signOut();
//               },
//               icon: Icon(Icons.exit_to_app))],
//         ),
//         bottomNavigationBar: const BottomNavBar(currentIndex: 1),
//         body: BlocConsumer<AuthCubit, AuthState>(
//           builder: (BuildContext context, AuthState state) {
//             return child: SafeArea(
//               child:  ProductsScreen(),
//             );
//           },
//           listenWhen: (previous, current) => current is AuthLoggedOut,
//           listener: (BuildContext context, AuthState state) {
//             Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => LoginForm()),
//                 (route) => false,
//           ); },
//
//         ),
//         );
//
//
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/bloc/auth/auth_cubit.dart';
import 'package:myproject/screens/product/widget/product_screen.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widget/bottom_nav_bar.dart';
import '../login_screen.dart';

class ProductsPageWrapper extends StatelessWidget {
  const ProductsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          BlocBuilder<AuthCubit,AuthState>
            (builder: (context, state) {
            if (state is AuthSuccess) {
              return IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/welcome' );
                },
                icon: const Icon(Icons.login),
              );
            }else{
              return IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                icon: const Icon(Icons.exit_to_app),
              );

            }
          }),

        ],
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) => current is AuthLoggedOut,
        listener: (context, state) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginForm()),
                (route) => false,
          );
        },

        builder: (context, state) {
          return const SafeArea(
            child: ProductsScreen(),
          );
        },
      ),
    );
  }
}

