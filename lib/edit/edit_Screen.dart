import 'package:evently_fluttter/core/firebase_functions.dart';
import 'package:evently_fluttter/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "AddEvent";

  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<EditScreen> {
  var selectedDate = DateTime.now();
  List<String> categories = [
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

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/back.png"),
        ),
        title: Text("Add Event", style: Theme.of(context).textTheme.bodyLarge),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/${categories[selectedCategoryIndex]}.png",
                height: 193,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 12),
            Container(
              height: 50,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedCategoryIndex = index;
                      setState(() {});
                    },
                    child: Chip(
                      label: Text(
                        categories[index].replaceAll("_", ' ').toUpperCase(),
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                          color: index != selectedCategoryIndex
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                      ),
                      backgroundColor: index == selectedCategoryIndex
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            Text("Title", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: titleController.text,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Description",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: descriptionController.text,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Image.asset("assets/images/calendar.png"),
                SizedBox(width: 8),
                Text(
                  "edit event",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    selectDateTime();
                  },
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    category: categories[selectedCategoryIndex],
                    date: selectedDate.millisecondsSinceEpoch,
                    description: descriptionController.text,
                    title: titleController.text,
                  );
                  FirebaseFunctions.updateTask;
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Edit Event",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectDateTime() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      builder: (context, child) => Theme(data: ThemeData(), child: child!),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}