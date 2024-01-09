import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:todo_tracker/activites/home_page.dart';
import 'package:todo_tracker/activites/side_drawer_bar.dart';
import 'package:todo_tracker/colors.dart';

class DrawerConnection extends StatefulWidget {
  const DrawerConnection({super.key});

  @override
  State<DrawerConnection> createState() => _DrawerConnectionState();
}

class _DrawerConnectionState extends State<DrawerConnection>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController1;

  @override
  void initState() {
    super.initState();
    animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenScale: .15,
      borderRadius: 24,
      mainScreenTapClose: true,
      // boxShadow: const [
      //   BoxShadow(
      //       color: backgroundColor, blurRadius: 6, blurStyle: BlurStyle.solid)
      // ],
      androidCloseOnBackTap: true,
      menuScreen: SideDrawerMenu(animationController: animationController1),
      mainScreen: HomePageToDoTracker(),
      angle: 0,
      menuBackgroundColor: blueBackgroundColor,
    );
  }
}
