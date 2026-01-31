
import 'package:flutter/material.dart';

import '../core/firebase_functions.dart';
import '../model/task_model.dart';

class FavoriteProvider extends ChangeNotifier{
  List<TaskModel> tasks = [];
  getFavoriteTasks(){
    FirebaseFunctions.getFavoriteStream().listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  updateTask(TaskModel task) async{
    await  FirebaseFunctions.updateTask(task);
  }

  deleteTask(TaskModel task) async{
    await  FirebaseFunctions.deleteTask(task);
  }
}