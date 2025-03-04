import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/core/utilities/configs/app_typography.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: AllColors.primaryGradientColor,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/images/profile3.jpg"),
          ),
          SizedBox(
            height: size.height * 0.020,
          ),
          Text(
            "Ahmed ",
            style: pp16w,
          ),
          SizedBox(
            height: size.height * 0.010,
          ),
          Text(
            "Junior flutter dev ",
            style: pp14W,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: size.height * 0.60,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    log("${texts[index]} YOUR TAB");
                  },
                  child: ListTile(
                    leading: Icon(
                      icons[index],
                      color: AllColors.white,
                    ),
                    title: Text(
                      texts[index],
                      style: pp14W,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
