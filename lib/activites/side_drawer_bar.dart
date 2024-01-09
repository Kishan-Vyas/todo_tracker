import 'package:flutter/material.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/data/globle_variable.dart';

class SideDrawerMenu extends StatefulWidget {
  AnimationController animationController;
  SideDrawerMenu({super.key, required this.animationController});

  @override
  State<SideDrawerMenu> createState() => _SideDrawerMenuState();
}

class _SideDrawerMenuState extends State<SideDrawerMenu>
    with SingleTickerProviderStateMixin {
  late Animation<double> lodingAnimation;

  @override
  void initState() {
    super.initState();

    widget.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    lodingAnimation = Tween<double>(
            begin: 0,
            end: (TOTALTASKCOUNT[0] + TOTALTASKCOUNT[1] + TOTALTASKCOUNT[2]) /
                (COMPLEDTASKCOUNT[0] +
                    COMPLEDTASKCOUNT[1] +
                    COMPLEDTASKCOUNT[2]))
        .animate(
      CurvedAnimation(parent: widget.animationController, curve: Curves.ease),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                  animation: lodingAnimation,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 83,
                          height: 83,
                          child: CircularProgressIndicator(
                            value: lodingAnimation.value,
                            strokeWidth: 2,
                            backgroundColor: Colors.grey.shade100,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
