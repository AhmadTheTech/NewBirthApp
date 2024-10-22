import 'package:flutter/material.dart';
import 'package:new_birth/bottomnav.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3) , (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff5f0cfb),
            Color(0xff982aea),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(image: AssetImage('assets/images/new_logo.png')  , width: 350, height: 350,),
            ),
          ],
        ),
      ),
    );
  }
}
