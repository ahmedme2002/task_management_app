import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_management_app/features/home/model/task_model/task_model.dart';

class HiveDataStore {
  static const boxName = "task box";

  final Box<TaskModel> box = Hive.box<TaskModel>(boxName);

  //AddNewTask
  Future<void> addNewTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  //ShowTask
  Future<TaskModel?> showTask({required String id}) async {
    return box.get(id);
  }

  //UpdateTask
  Future<void> updateTask({required TaskModel task}) async {
    await task.save();
  }

  //DeleteTask
  Future<void> deleteTask({required TaskModel task}) async {
    await task.delete();
  }

  //ListenToBoxChanges
  ValueListenable<Box<TaskModel>> listenToTask() => box.listenable();
}
