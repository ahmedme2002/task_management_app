import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:task_management_app/core/utilities/configs/app_st.dart';
import 'package:task_management_app/core/utilities/configs/app_typography.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';
import 'package:task_management_app/core/utilities/constants/constants.dart';
import 'package:task_management_app/features/home/model/task_model/task_model.dart';
import 'package:task_management_app/features/home/presentation/pages/home_screen/home_screen.dart';
import 'package:task_management_app/features/tasks/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:task_management_app/features/tasks/presentation/components/task_view_app_bar/task_view_app_bar.dart';
import 'package:task_management_app/features/tasks/presentation/components/timer_selection_widget/timer_selection_widget.dart';
import 'package:task_management_app/main.dart';
import 'package:uuid/uuid.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    this.task,
    this.titleController,
    this.noteController,
  });

  final TaskModel? task;
  final TextEditingController? titleController;
  final TextEditingController? noteController;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  String? title;
  String? subtitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title = widget.task!.title;
      subtitle = widget.task!.subtitle;
      date = widget.task!.createdAtDate;
      time = widget.task!.createdAtTime;

      widget.titleController?.text = title ?? '';
      widget.noteController?.text = subtitle ?? '';
    }
  }

  bool isEditing() => widget.task != null;

  void saveTask() {
    if (title == null || title!.trim().isEmpty) {
      emptyWarning(context);
      return;
    }

    if (isEditing()) {
      widget.task
        ?..title = title!
        ..subtitle = subtitle!
        ..createdAtDate = date ?? widget.task!.createdAtDate
        ..createdAtTime = time ?? widget.task!.createdAtTime;

      widget.task!.save();
    } else {
      final newTask = TaskModel.create(
        id: const Uuid().v4(),
        title: title!,
        subtitle: subtitle ?? '',
        createdAtDate: date ?? DateTime.now(),
        createdAtTime: time ?? DateTime.now(),
      );

      BaseWidget.of(context).dataStore.addNewTask(task: newTask);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  String showTime(DateTime? time) {
    return DateFormat('hh:mm a').format(time ?? DateTime.now());
  }

  String showDate(DateTime? date) {
    return DateFormat.yMMMEd().format(date ?? DateTime.now());
  }

  DateTime initialDateTime(DateTime? date) {
    return date ?? DateTime.now();
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.10,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 70, child: Divider(thickness: 2)),
                        RichText(
                          text: TextSpan(
                            text: isEditing()
                                ? AppStr.updateCurrentTask
                                : AppStr.addNewTask,
                            style: pp30,
                            children: [
                              TextSpan(text: " Task", style: pp30b),
                            ],
                          ),
                        ),
                        const SizedBox(width: 70, child: Divider(thickness: 2)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("What are You Planning?", style: pp14g),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextField(
                            maxLines: 6,
                            controller: widget.titleController,
                            onChanged: (inputTitle) => title = inputTitle,
                          ),
                        ),
                        SizedBox(height: size.height * 0.010),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextField(
                            hintText: "Add Note",
                            controller: widget.noteController,
                            prefixIcon:
                                const Icon(Icons.bookmark_border_outlined),
                            onChanged: (inputSubtitle) =>
                                subtitle = inputSubtitle,
                          ),
                        ),
                        SizedBox(height: size.height * 0.020),
                        TimerSelectionWidget(
                          size: size,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: 280,
                                child: TimePickerWidget(
                                  initDateTime: initialDateTime(time),
                                  dateFormat: 'HH:mm',
                                  onChange: (dateTime, _) {},
                                  onConfirm: (dateTime, _) {
                                    setState(() => time = dateTime);
                                  },
                                ),
                              ),
                            );
                          },
                          title: "Time",
                          date: showTime(time),
                        ),
                        SizedBox(height: size.height * 0.020),
                        TimerSelectionWidget(
                          size: size,
                          onTap: () {
                            DatePicker.showDatePicker(
                              initialDateTime: initialDateTime(date),
                              context,
                              maxDateTime: DateTime(2030, 4, 5),
                              minDateTime: DateTime.now(),
                              onConfirm: (dateTime, _) {
                                setState(() => date = dateTime);
                              },
                            );
                          },
                          isTime: true,
                          title: "Date",
                          date: showDate(date),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: isEditing()
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      if (isEditing())
                        GestureDetector(
                          onTap: () {
                            deleteTask();
                            Navigator.pop(context);
                            // You should also implement delete logic here if necessary.
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            decoration: BoxDecoration(
                              color: AllColors.white,
                              border: Border.all(
                                  color: AllColors.blueAccent, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.close,
                                    color: AllColors.blueAccent),
                                SizedBox(width: size.width * 0.010),
                                const Text(
                                  "Delete Task",
                                  style: TextStyle(
                                      color: AllColors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: saveTask,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          decoration: BoxDecoration(
                            color: AllColors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isEditing() ? "Update Task" : "Add Task",
                            style: const TextStyle(
                                color: AllColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
