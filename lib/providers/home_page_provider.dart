import 'dart:async';


import 'package:flutter/material.dart';

import '../core/firebase_functions.dart';
import '../model/task_model.dart';

class HomeTabProvider extends ChangeNotifier {
  List<String> categories = [
    "All",
    "book_club",
    "meeting",
    "eating",
    "gaming",
    "holiday",
    "birthday",
    "sport",
    "exhibition",
    "workshop",
  ];

  List<TaskModel> tasks = [];
  bool isLoading = false;
  String errorMessage = "";
  int selectedCategoryIndex = 0;

  StreamSubscription? streamSubscription;

  changeCategoryIndex(int index) {
    selectedCategoryIndex = index;
    // getTasks();
    getTasksStream();
    notifyListeners();
  }

  @override
  dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }
  getTasksStream() {
    FirebaseFunctions.getTasksStream(
      category: selectedCategoryIndex == 0
          ? null
          : categories[selectedCategoryIndex],
    ).listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  updateTask(TaskModel task) async {
    await FirebaseFunctions.updateTask(task);
  }
  deleteTask(TaskModel task) async{
    await FirebaseFunctions.deleteTask(task);
  }


// getTasks() async {
//   try {
//     isLoading = true;
//     var list = await FirebaseFunctions.getTasks(
//       category: selectedCategoryIndex == 0
//           ? null
//           : categories[selectedCategoryIndex],
//     );
//     tasks = list.docs.map((e) => e.data()).toList();
//   } catch (e) {
//     errorMessage = e.toString();
//   }
//   isLoading = false;
//   notifyListeners();
// }
}