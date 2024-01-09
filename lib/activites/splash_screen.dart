import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_tracker/activites/drawer_connection.dart';
import 'package:todo_tracker/activites/home_page.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/decoration_container/dec_frosted_card_design.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  bool isSplashDone = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 12).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    scaleAnimation.addListener(() {
      if (animationController.isCompleted) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const DrawerConnection();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
        Timer(
          const Duration(milliseconds: 700),
          () {
            animationController.reset();
            setState(() {
              isSplashDone = !isSplashDone;
            });
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Colors.black,
                Color.fromARGB(255, 43, 3, 50),
                Colors.black,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Lottie.asset(
                        'animations/lottie_animation_splash_screen.json',
                        height: 300,
                        repeat: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          "Turn 'I wish' into 'I will'",
                          style: TextStyle(
                            color: mainFillColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Success is the sum of small efforts \nrepeated day in and day out",
                            style: TextStyle(
                              color: mainFillColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 60.0),
                        child: GestureDetector(
                          onTap: () {
                            animationController.forward();
                            setState(() {
                              isSplashDone = !isSplashDone;
                            });
                          },
                          child: const DecFrostedCardDesign(
                            theHeight: 60.0,
                            theWidth: 400.0,
                            theChild: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 27,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                height: isSplashDone ? 1000 : 0,
                color: backgroundColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
