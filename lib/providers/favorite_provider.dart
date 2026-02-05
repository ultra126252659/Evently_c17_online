import 'package:evently_fluttter/core/firebase_functions.dart';
import 'package:evently_fluttter/models/task_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  getTasks() {
    FirebaseFunctions.getFavoriteTasks().listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  updateTask(TaskModel task) async {
    await FirebaseFunctions.updateTask(task);
  }
}