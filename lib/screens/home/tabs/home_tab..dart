import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/core/extensions.dart';
import 'package:evently_fluttter/providers/home_page_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/detils_event/detalis_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final DateFormat formatter = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
 var provide = Provider.of<ThemeProvider>(context); // هذا السطر غير مستخدم ويمكن حذفه لتنظيف الكود

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider()..getTasksStream(),
        ),
      ],
      builder: (context, child) {
        final provider = context.watch<HomePageProvider>();

        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemCount: provider.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => provider.changeCategory(index),
                        child: Chip(
                          label: Text(
                            provider.categories[index].replaceAll("_", ' ').toUpperCase(),
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: index != provider.selectedCategoryIndex
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                            ),
                          ),
                          backgroundColor: index == provider.selectedCategoryIndex
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
                const SizedBox(height: 12),

                // قائمة المهام
                Expanded(
                  child: provider.taskss.isEmpty
                      ? Center(
                    child: Text(
                      "No Tasks Yet",
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  )
                      : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemCount: provider.taskss.length,
                    itemBuilder: (context, index) => Slidable(
                      key: ValueKey(provider.taskss[index].id),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => provider.deleteTask(provider.taskss[index]),
                            backgroundColor: Colors.transparent,
                            foregroundColor: const Color(0xFFFE4A49),
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // Navigator.pushNamed(context, AddEventScreen.routeName, arguments: provider.taskss[index]);
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          )
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        height: 193,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // ==========================================
                            // 1. الصورة الخلفية (تم تغليفها بـ GestureDetector)
                            // ==========================================
                            GestureDetector(
                              onTap: () {
                                // الانتقال لشاشة التفاصيل وتمرير البيانات
                                Navigator.pushNamed(
                                  context,
                                  DetailsEventScreen.routeName, // تأكد أن هذا الاسم مطابق لما في main.dart
                                  arguments: provider.taskss[index],
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  context.brightness() == Brightness.light
                                      ? "assets/images/${provider.taskss[index].category}.png"
                                      : "assets/images/${provider.taskss[index].category}dark.png",
                                  width: double.infinity,
                                  height: double.infinity, // تأكدت أنها تأخذ الطول الكامل
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 2. المحتوى (التاريخ والعنوان) - كما هو لم يتغير
                            // بما أنه يأتي بعد الصورة في الـ Stack، فأزراره ستعمل بشكل طبيعي فوق الصورة
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFFF0F0F0)),
                                  child: Text(
                                    formatter.format(DateTime.fromMillisecondsSinceEpoch(provider.taskss[index].date)),
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F0F0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.taskss[index].title,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      ),
                                      // الـ InkWell هنا سيعمل بشكل منفصل للإعجاب
                                      InkWell(
                                        onTap: () {
                                          var task = provider.taskss[index];
                                          task.isFavorite = !task.isFavorite;
                                          provider.updateTask(task);
                                        },
                                        child: Icon(
                                          provider.taskss[index].isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
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