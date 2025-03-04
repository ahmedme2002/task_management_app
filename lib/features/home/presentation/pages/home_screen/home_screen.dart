import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_app/core/utilities/configs/app_typography.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';
import 'package:task_management_app/core/utilities/constants/constants.dart';
import 'package:task_management_app/features/home/model/task_model/task_model.dart';
import 'package:task_management_app/features/home/presentation/components/floating_button/floating_button.dart';
import 'package:task_management_app/features/home/presentation/components/task_builder/task_builder.dart';
import 'package:task_management_app/features/home/presentation/components/home_app_bar/home_app_bar.dart';
import 'package:task_management_app/features/home/presentation/pages/slider_drawer/custom_drawer.dart';
import 'package:task_management_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  double _getCompletionRate(List<TaskModel> tasks) {
    if (tasks.isEmpty) return 0.0;
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    return completedTasks / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<TaskModel> box, Widget? child) {
        final tasks = box.values.toList();

        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          floatingActionButton: const FloatingButton(),
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: true,
            animationDuration: 600,
            slider: const CustomDrawer(),
            appBar: HomeAppBar(drawerKey: drawerKey),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  _buildHeader(size, tasks),
                  SizedBox(height: size.height * 0.015),
                  Divider(indent: size.width * 0.10, thickness: 2),
                  SizedBox(height: size.height * 0.005),
                  Expanded(
                      child: _buildTaskListOrEmptyState(size, base, tasks)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Size size, List<TaskModel> tasks) {
    final completedTasks = tasks.where((task) => task.isCompleted).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            value: _getCompletionRate(tasks),
            backgroundColor: AllColors.grey,
            valueColor: const AlwaysStoppedAnimation(AllColors.primaryColor),
          ),
        ),
        SizedBox(width: size.width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Tasks", style: pp40b),
            SizedBox(height: size.height * 0.005),
            Text(
              "$completedTasks of ${tasks.length} tasks",
              style: pp16g,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskListOrEmptyState(
    Size size,
    BaseWidget base,
    List<TaskModel> tasks,
  ) {
    if (tasks.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 10),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task.id),
            direction: DismissDirection.horizontal,
            onDismissed: (_) => base.dataStore.deleteTask(task: task),
            background: _buildDismissBackground(size),
            child: TaskBuilder(task: task),
          );
        },
      );
    } else {
      return _buildEmptyState(size);
    }
  }

  Widget _buildDismissBackground(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.delete, color: AllColors.grey),
        SizedBox(width: size.width * 0.02),
        Text("This task was deleted", style: pp14g),
      ],
    );
  }

  Widget _buildEmptyState(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeIn(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 250,
              width: 250,
              child: LottieBuilder.asset(LottieURL),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInUp(
          from: 30,
          child: Text("You Have Done All Tasks!"),
        ),
      ],
    );
  }
}
