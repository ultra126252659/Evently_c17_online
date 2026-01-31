import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/StringApp..dart';
import '../../core/style_app.dart';
import '../../model/task_model.dart';
import '../../providers/home_page_provider.dart';
import '../../providers/theme_provider.dart';
import '../addevent/add_event_screen.dart';

class  DetailsEventScreen extends StatelessWidget {
  static const String routeName = '/detailsEvent';
  const  DetailsEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final model = ModalRoute.of(context)!.settings.arguments as TaskModel;
    DateFormat formatDate = DateFormat("dd MMM");
    return ChangeNotifierProvider(
        create: (context)=>HomeTabProvider()..getTasksStream(),
        builder: (context, child){
          final provider = context.watch<HomeTabProvider>();
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: IconButton(
                  iconSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/assets/images/back_ic.png",

                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  )
              ),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Event details",
                  style: StyleApp.titleStyleLocalize.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  )
              ),
              actions: [

                IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, AddEventScreen.routeName,arguments: model);
                    },
                    icon: Image.asset("assets/images/edit.png",)
                ),
                IconButton(
                    padding: EdgeInsets.only(right: 15),
                    onPressed: (){
                      provider.deleteTask(model);
                      Navigator.pop(context);
                    },
                    icon: Image.asset("assets/images/delete.png",)
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 20,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:themeProvider.themeMode == ThemeMode.light? Image.asset("assets/images/${model.category}.png",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ): Image.asset("assets/images/${model.category}dark.png",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(model.title,
                    style: StyleApp.titleStyleLocalize.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),

                  ),
                  Container(
                    width: double.infinity,

                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children:[
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ImageIcon(AssetImage("assets/images/calendar-add.png"),
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),

                          ),
                          Expanded(child: Text(formatDate.format(DateTime.fromMillisecondsSinceEpoch(model.date)),
                              style: StyleApp.titleStyleLocalize
                          )),


                        ]
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      Text("description".tr(),
                        textAlign: TextAlign.start,
                        style: StyleApp.descriptionStyleLocalize.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(model.description,
                          style: StyleApp.descriptionStyleLocalize.copyWith(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          );
        }

    );
  }
}