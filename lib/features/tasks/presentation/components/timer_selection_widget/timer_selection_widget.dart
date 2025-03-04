import 'package:flutter/material.dart';
import 'package:task_management_app/core/utilities/configs/app_typography.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';

class TimerSelectionWidget extends StatelessWidget {
  const TimerSelectionWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.title,
    required this.date,
    this.isTime = false,
  });

  final Size size;
  final VoidCallback onTap;
  final String title;
  final String date;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.070,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AllColors.white,
          border: Border.all(color: AllColors.greyLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: pp14g3,
            ),
            Container(
              width: isTime ? size.width * 0.35 : size.width * 0.20,
              height: size.height * 0.10,
              decoration: BoxDecoration(
                color: AllColors.greyshade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  date,
                  style: pp14b,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
