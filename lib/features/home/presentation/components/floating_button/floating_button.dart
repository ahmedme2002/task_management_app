import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';
import 'package:task_management_app/features/tasks/presentation/pages/task_view.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});
  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const TaskView(),
            ));
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AllColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: AllColors.white,
        ),
      ),
    );
  }
}
