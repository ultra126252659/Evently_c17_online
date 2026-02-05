import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/models/task_model.dart';
import 'package:evently_fluttter/providers/home_page_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/add_event/add_event_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailsEventScreen extends StatelessWidget {
  static const String routeName = '/detailsEvent';
  const DetailsEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final model = ModalRoute.of(context)!.settings.arguments as TaskModel;
    DateFormat formatDate = DateFormat("dd MMM");

    // متغيرات لتسهيل التعامل مع الألوان في اللايت والدارك
    bool isLight = themeProvider.themeMode == ThemeMode.light;
    Color cardColor = isLight ? Colors.white : Theme.of(context).colorScheme.surface;
    Color textColor = isLight ? Colors.black : Colors.white;
    Color subTextColor = isLight ? Colors.black54 : Colors.white70;

    return ChangeNotifierProvider(
      create: (context) => HomePageProvider()..getTasksStream(),
      builder: (context, child) {
        final provider = context.watch<HomePageProvider>();
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface, // الخلفية السماوي
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                iconSize: 30,
                // أيقونة الرجوع لونها أزرق زي التصميم
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back) // أو الصورة بتاعتك لو عايز
              // icon: Image.asset("assets/images/back_ic.png", width: 30, height: 30, fit: BoxFit.cover,),
            ),
            centerTitle: true,
            title: Text(
              "Event details",
              style:TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddEventScreen.routeName, arguments: model);
                },
                icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 15),
                onPressed: () {
                  provider.deleteTask(model);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete, color: Colors.red)

              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: isLight
                      ? Image.asset(
                    "assets/images/${model.category}.png",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    "assets/images/${model.category}dark.png",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),


                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),


                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isLight ? Colors.transparent : Colors.white24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isLight ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),

                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate.format(DateTime.fromMillisecondsSinceEpoch(model.date)),
                              style:TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "12:00 PM",
                              style: TextStyle(color: subTextColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),


                Text(
                  "Description".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor, // أسود
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor, // أبيض في اللايت
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isLight ? Colors.transparent : Colors.white24),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        model.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: subTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}