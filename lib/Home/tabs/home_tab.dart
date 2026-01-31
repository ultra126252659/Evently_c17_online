import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../core/style_app.dart';
import '../../providers/home_page_provider.dart';
import '../../providers/theme_provider.dart';
import '../../screens/addevent/add_event_screen.dart';
import '../../screens/detils_event/detalis_event_screen.dart';
class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateFormat formatDate = DateFormat("dd MMM");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>HomeTabProvider()..getTasksStream(),
        builder: (context, child){
          var themeProvider = Provider.of<ThemeProvider>(context);
          final provider = context.watch<HomeTabProvider>();
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical:10,horizontal: 22),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index) =>InkWell(
                        onTap: (){
                          provider.selectedCategoryIndex;

                        },
                        child: Chip(
                            backgroundColor: provider.selectedCategoryIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.transparent,

                                )
                            ),
                            label: Text(provider.categories[index],
                              style: StyleApp.descriptionStyleLocalize.copyWith(
                                fontSize: 18,
                                color: provider.selectedCategoryIndex == index ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
                              ),
                            )),
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemCount: provider.categories.length),
                ),
                Expanded(
                    child:provider.tasks.isEmpty? Center(child: Text("No Tasks Yet",
                      style: StyleApp.descriptionStyleLocalize.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),) :ListView.separated(
                      itemBuilder: (context, index) =>
                          Slidable(
                            key: ValueKey(provider.tasks[index].id),
                            startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      var task = provider.tasks[index];
                                      provider.deleteTask(task);
                                    },
                                    backgroundColor: Colors.transparent ,
                                    foregroundColor: Color(0xFFFE4A49),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ]
                            ),
                            endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      Navigator.pushNamed(context,
                                          AddEventScreen.routeName,
                                          arguments: provider.tasks[index]);
                                    },
                                    backgroundColor: Colors.transparent ,
                                    foregroundColor:Theme.of(context).colorScheme.primary,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  )
                                ]
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child:themeProvider.themeMode == ThemeMode.light?
                                  Image.asset("assets/images/${provider.tasks[index].category}.png",
                                    width: double.infinity,
                                    height: 230,
                                    fit: BoxFit.cover,
                                  ):Image.asset("assets/images/${provider.tasks[index].category}dark.png",
                                    width: double.infinity,
                                    height: 230,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                      child: Text(formatDate.format(DateTime.fromMillisecondsSinceEpoch(provider.tasks[index].date)) ,
                                        style: StyleApp.descriptionStyleLocalize.copyWith(
                                          fontSize: 18,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    )
                                ),
                                Center(
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, DetailsEventScreen.routeName,
                                            arguments: provider.tasks[index]);
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                        width:double.infinity,
                                        height: 200,
                                      ),
                                    )
                                ),
                                Positioned(
                                    bottom: 15,
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(17),
                                          color: Theme.of(context).colorScheme.background,
                                        ),
                                        child: Row(
                                            children: [
                                              Expanded(child: GestureDetector(
                                                onTap: (){
                                                  Navigator.pushNamed(context, DetailsEventScreen.routeName,
                                                      arguments: provider.tasks[index]);
                                                },
                                                child: Text(provider.tasks[index].title,
                                                  style: StyleApp.descriptionStyleLocalize.copyWith(
                                                    fontSize: 18,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                  ),
                                                ),
                                              )),
                                              IconButton(
                                                  onPressed: (){
                                                    var task = provider.tasks[index];
                                                    task.isFavorite = !task.isFavorite;
                                                    provider.updateTask(task);
                                                  },
                                                  icon: Icon(
                                                    provider.tasks[index].isFavorite ? Icons.favorite: Icons.favorite_border,
                                                    color: Theme.of(context).colorScheme.primary,
                                                    size: 30,
                                                  )
                                              ),


                                            ]
                                        )
                                    )
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: provider.tasks.length,
                    )
                )
              ],
            ),
          );
        }

    );
  }
}