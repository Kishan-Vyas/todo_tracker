import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:todo_tracker/colors.dart';

class DecHomepageNavagationBar extends StatefulWidget {
  Function(String) textChange;
  final TextEditingController textFilterController;
  DecHomepageNavagationBar({
    super.key,
    required this.textFilterController,
    required this.textChange,
  });

  @override
  State<DecHomepageNavagationBar> createState() =>
      _DecHomepageNavagationBarState();
}

class _DecHomepageNavagationBarState extends State<DecHomepageNavagationBar> {
  bool isSearchButtonSelectedAnim = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => ZoomDrawer.of(context)!.toggle(),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mainFillColor,
              ),
              child: const Icon(
                Icons.menu,
                color: mainColor,
                size: 28,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isSearchButtonSelectedAnim = !isSearchButtonSelectedAnim;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSearchButtonSelectedAnim ? 220 : 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        isSearchButtonSelectedAnim ? 15 : 10),
                    color: mainFillColor,
                  ),
                  child: isSearchButtonSelectedAnim
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: TextField(
                            controller: widget.textFilterController,
                            onChanged: widget.textChange,
                            cursorColor: mainColor,
                            decoration: const InputDecoration(
                                hintText: 'Search',
                                focusColor: mainColor,
                                fillColor: mainColor,
                                hintStyle: TextStyle(color: mainColor)),
                          ),
                        )
                      : null,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSearchButtonSelectedAnim ? 55 : 45,
                  height: isSearchButtonSelectedAnim ? 55 : 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          isSearchButtonSelectedAnim ? 20 : 10),
                      color: isSearchButtonSelectedAnim
                          ? mainColor
                          : mainFillColor),
                  child: Icon(
                    Icons.search,
                    color:
                        isSearchButtonSelectedAnim ? mainFillColor : mainColor,
                    size: isSearchButtonSelectedAnim ? 32 : 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
