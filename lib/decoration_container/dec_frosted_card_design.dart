import 'dart:ui';

import 'package:flutter/material.dart';

class DecFrostedCardDesign extends StatelessWidget {
  final theChild;
  final theWidth;
  final theHeight;

  const DecFrostedCardDesign({
    super.key,
    this.theChild,
    this.theWidth,
    this.theHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: theHeight,
        width: theWidth,
        color: Colors.transparent,
        child: Stack(
          children: [
            // blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(),
            ),
            // gradient
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.89),
                    width: 1.5,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.93),
                        Colors.black.withOpacity(0.64),
                      ])),
            ),
            // child
            Center(
              child: theChild,
            )
          ],
        ),
      ),
    );
  }
}
