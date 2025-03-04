import 'package:flutter/material.dart';

class TaskViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskViewAppBar({super.key});

  @override
  State<TaskViewAppBar> createState() => _TaskViewAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _TaskViewAppBarState extends State<TaskViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
