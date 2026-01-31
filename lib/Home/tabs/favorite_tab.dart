import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/style_app.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/theme_provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>FavoriteProvider().. getFavoriteTasks(),
      builder: (context, child){
        var themeProvider = Provider.of<ThemeProvider>(context);
        var provider = Provider.of<FavoriteProvider>(context);
        DateFormat formatDate = DateFormat("dd MMM");
        return  Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.background,
          child: Column(
              children: [
                Expanded(
                    child:provider.tasks.isEmpty? Center(child: Text("No Favorite Tasks Yet",
                      style: StyleApp.descriptionStyleLocalize.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),) :ListView.separated(
                      itemBuilder: (context, index) =>  Stack(
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
                                        Expanded(child: Text(provider.tasks[index].title,
                                          style: StyleApp.descriptionStyleLocalize.copyWith(
                                            fontSize: 18,
                                            color: Theme.of(context).colorScheme.onSurface,
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
                                        IconButton(
                                            onPressed: (){
                                              var task = provider.tasks[index];
                                              provider.deleteTask(task);
                                            },
                                            icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context).colorScheme.primary,
                                                size: 30
                                            )
                                        )
                                      ]
                                  )
                              )
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: provider.tasks.length,
                    )
                )
              ]
          ),
        );
      },
    );
  }
}