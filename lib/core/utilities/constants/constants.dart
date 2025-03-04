import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:task_management_app/main.dart';

// ignore: non_constant_identifier_names
String LottieURL = "assets/lottie/1.json";

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: "Oops",
    subMsg: "You must fill all fields ! ",
    corner: 20.0,
    duration: 1500,
    padding: const EdgeInsets.all(20),
  );
}

dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: "Oops!",
    subMsg: "You must edit the tasks then try to update it!",
    corner: 20.0,
    duration: 1500,
    padding: const EdgeInsets.all(20),
  );
}

dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    buttonText: "Okay",
    title: "Oops!",
    message:
        "There is no Task For Delete!\nTry adding some and then try to\ndelete it!",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

dynamic deleteAllTasks(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: "Are You Sure?",
    message:
        "Do You really want to delete all\n tasks? You will no be able to\n undo this action! ",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
  );
}
