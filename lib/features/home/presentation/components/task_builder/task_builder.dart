import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';
import 'package:task_management_app/features/home/model/task_model/task_model.dart';
import 'package:task_management_app/features/tasks/presentation/pages/task_view.dart';

class TaskBuilder extends StatefulWidget {
  const TaskBuilder({super.key, required this.task});
  final TaskModel task;
  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subtitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TaskView(
              task: widget.task,
              noteController: textEditingControllerForSubTitle,
              titleController: textEditingControllerForTitle,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? Color.fromARGB(154, 119, 144, 229)
              : AllColors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              padding: const EdgeInsets.all(8), // Proper padding
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AllColors.primaryColor
                    : AllColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AllColors.grey,
                  width: 0.8,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: AllColors.white,
                size: 18,
              ),
            ),
          ),
          title: Text(
            textEditingControllerForTitle.text,
            style: TextStyle(
              color: widget.task.isCompleted
                  ? AllColors.primaryColor
                  : AllColors.black,
              fontWeight: FontWeight.w500,
              decoration:
                  widget.task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AllColors.primaryColor
                      : AllColors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("hh:mm a").format(widget.task.createdAtTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.task.isCompleted
                              ? AllColors.white
                              : AllColors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.task.isCompleted
                              ? AllColors.white
                              : AllColors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
