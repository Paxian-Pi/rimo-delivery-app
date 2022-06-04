import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rimo Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoarding()
    );
  }

  Widget _splash() {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: 'assets/splash.png',
      nextScreen: const OnBoarding(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
