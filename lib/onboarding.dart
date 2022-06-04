import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'button_widget.dart';
import 'login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: SafeArea(
            child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: '',
                  body: '',
                  image: null,
                  decoration: gePageDecoration(),
                  footer: _buttons(context)
                ),
              ],
              done: const Text(
                'Next',
                style: TextStyle(fontSize: 20),
              ),
              onDone: () => _login(context),
              doneColor: Colors.black,
              showSkipButton: true,
              skip: const Text(
                'Skip',
                style: TextStyle(fontSize: 20),
              ),
              skipColor: Colors.black,
              skipFlex: 0,
              nextFlex: 0,
              nextColor: Colors.black,
              next: const Icon(Icons.arrow_forward),
              dotsDecorator: getDotDecorator(),
              // onChange: (index) => print('Page $index selected'),
              globalBackgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBackgroundImage(String path) {
    return Center(
      child: Image.asset(path, width: 550, height: 500),
    );
  }
  
  PageDecoration gePageDecoration() => PageDecoration(
    boxDecoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/onboarding.png"),
        fit: BoxFit.cover,
      ),
    ),
    titleTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.0),
        fontSize: 30,
        fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.0), fontSize: 25),
    descriptionPadding: const EdgeInsets.all(16),
    imagePadding: const EdgeInsets.only(top: 280.0),
    contentMargin: const EdgeInsets.only(top: 370.0),
    // pageColor: Constant.white,
  );
  
  DotsDecorator getDotDecorator() => DotsDecorator(
      color: Colors.grey,
      size: const Size(10, 10),
      activeColor: Colors.blue.shade200,
      activeSize: const Size(21, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));
}

Widget _buttons(BuildContext context) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
        
        },
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          shadowColor: Colors.grey,
          elevation: 3,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade300],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'New Driver',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          _login(context);
        },
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.blue.shade300,
          shadowColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.blue.shade300)
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void _login(context) {

  Navigator.of(context).pushReplacement(
    PageTransition(
      type: PageTransitionType.bottomToTop,
      child: const Login(),
    ),
  );
}
