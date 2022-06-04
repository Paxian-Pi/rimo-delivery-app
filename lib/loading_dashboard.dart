import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'google_map.dart';

class LoadingDashboard extends StatefulWidget {
  const LoadingDashboard({Key? key}) : super(key: key);

  @override
  State<LoadingDashboard> createState() => _LoadingDashboardState();
}

class _LoadingDashboardState extends State<LoadingDashboard> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          child: MapSample(),
          type: PageTransitionType.fade,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/loading_dashboard.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
