import 'dart:async';

import 'package:flutter/material.dart';

import '../colors.dart';

// ignore: must_be_immutable
class UtilFABHome extends StatefulWidget {
  VoidCallback onPressed;

  UtilFABHome({super.key, required this.onPressed});

  @override
  State<UtilFABHome> createState() => _UtilFABHomeState();
}

class _UtilFABHomeState extends State<UtilFABHome>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scallTransitionAnimation;
  late Animation<Offset> slidAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    scallTransitionAnimation = Tween<double>(begin: 1, end: 6).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    slidAnimation = Tween(begin: Offset.zero, end: Offset.zero).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animationController.forward();
        Timer(const Duration(milliseconds: 600), () {
          widget.onPressed();
        });
      },
      child: const Stack(
        alignment: Alignment.bottomRight,
        children: [
          FloatingActionButton(
            onPressed: null,
            backgroundColor: mainFillColor,
            child: Icon(
              Icons.add,
              color: mainColor,
              size: 28,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ScaleTransition(
          //     scale: scallTransitionAnimation,
          //     child: SlideTransition(
          //       position: slidAnimation,
          //       child: AnimatedContainer(
          //         duration: Duration(milliseconds: 600),
          //         width: 45,
          //         height: 45,
          //         decoration: BoxDecoration(color: mainFillColor),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
