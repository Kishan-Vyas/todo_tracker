import 'package:flutter/material.dart';
import 'package:todo_tracker/decoration_container/dec_frosted_card_design.dart';

class DecCatagoryCard extends StatefulWidget {
  final IconData catagoryIcon;
  final double progress;
  final String catagoryName;
  final Color tempColor;
  const DecCatagoryCard({
    super.key,
    required this.catagoryIcon,
    required this.progress,
    required this.tempColor,
    required this.catagoryName,
  });

  @override
  State<DecCatagoryCard> createState() => _DecCatagoryCardState();
}

class _DecCatagoryCardState extends State<DecCatagoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> lodingAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    lodingAnimation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
      child: DecFrostedCardDesign(
        theWidth: 201.0,
        theHeight: 156.0,
        theChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(179, 66, 65, 65),
                        ),
                        child: Icon(
                          widget.catagoryIcon,
                          color: widget.tempColor,
                        ),
                      ),
                      const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  AnimatedBuilder(
                      animation: lodingAnimation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                value: lodingAnimation.value,
                                strokeWidth: 10,
                                backgroundColor: Colors.grey.shade100,
                                color: widget.tempColor,
                              ),
                            ),
                            Text(
                              '${(lodingAnimation.value * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 22, right: 22, top: 3, bottom: 16),
              child: Text(
                widget.catagoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
