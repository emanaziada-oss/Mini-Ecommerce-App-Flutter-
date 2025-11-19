import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState (){
    super.initState();
    Timer(Duration(seconds: 3),() {
      Navigator.pushNamed(context, '/welcom');
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea (
        child: Scaffold(
            body: Container(
              width:double.infinity,
              height: double.infinity,
              color: Color(0xFFFF6A77),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      child: Image.asset('assets/welcome/2.png')
                  ),
                  Positioned(
                      top: 300,
                      left: 100,
                      child: Image.asset('assets/welcome/group1.png')
                  ),
                ],
              ),
            )
        )
    ); ;
  }
}
