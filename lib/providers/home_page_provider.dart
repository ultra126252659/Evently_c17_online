import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_fluttter/core/firebase_functions.dart';
import 'package:evently_fluttter/models/task_model.dart';
import 'package:flutter/material.dart';



class HomePageProvider extends ChangeNotifier {
  List<String> categories = [
    "All",
    "sport",
    "birthday",
    "book_club",
    "exhibition",
    "holiday",
    "meeting",
    "eating",
    "workshop",
    "gaming",
  ];

  List<TaskModel> taskss = [];

  int selectedCategoryIndex = 0;

  StreamSubscription<QuerySnapshot<TaskModel>>? _tasksSubscription;

  changeCategory(int index) {
    selectedCategoryIndex = index;
    getTasksStream();
    notifyListeners();
  }

  // getTasks() async {
  //   QuerySnapshot<TaskModel> data;
  //   if (selectedCategoryIndex != 0) {
  //     data = await FirebaseFunctions.getTasks(
  //       category: categories[selectedCategoryIndex],
  //     );
  //   } else {
  //     data = await FirebaseFunctions.getTasks();
  //   }
  //
  //   taskss = data.docs.map((e) => e.data()).toList();
  //   notifyListeners();
  // }

  getTasksStream() {
    _tasksSubscription?.cancel();
    _tasksSubscription = FirebaseFunctions.getTasksStream(
      category: selectedCategoryIndex == 0
          ? null
          : categories[selectedCategoryIndex],
    ).listen((event) {
      taskss = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  updateTask(TaskModel task) async {
    await FirebaseFunctions.updateTask(task);
  }
  deleteTask(TaskModel task) async{
    await FirebaseFunctions.deleteTask(task);
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}