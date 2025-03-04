import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:task_management_app/core/utilities/constants/constants.dart';
import 'package:task_management_app/main.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});
  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // Faster animation
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      if (isDrawerOpen) {
        _animationController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      } else {
        _animationController.forward();
        widget.drawerKey.currentState!.openSlider();
      }
      isDrawerOpen = !isDrawerOpen; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onDrawerToggle,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close, // Menu icon first, then close
                progress: _animationController,
                size: 40,
              ),
            ),
            GestureDetector(
              onTap: () {
                base.isEmpty ? noTaskWarning(context) : deleteAllTasks(context);
              },
              child: const Icon(
                CupertinoIcons.delete,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
