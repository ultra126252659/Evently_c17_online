import 'package:evently_fluttter/Home/tabs/favorite_tab.dart';
import 'package:evently_fluttter/Home/tabs/home_tab.dart';
import 'package:evently_fluttter/Home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/my_theme_data.dart';
import '../providers/home_provider..dart';
import '../screens/addevent/add_event_screen.dart';


class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              ImageIcon(
                AssetImage("assets/images/light.png"),
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyThemeData.lightTheme.primaryColor,
                ),
                child: Text(
                  "EN",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(width: 8),
            ],
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Welcome Back ✨",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                "John Safwat",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: Color(0xFF1c1c1c)),
              ),
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.selectedIndex,
            onTap: (value) {
              provider.changeIndex(value);
            },
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/home-2.png")),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/heart.png")),
                label: "Favorite",
              ),

              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/user.png")),
                label: "Profile",
              ),
            ],
          ),
          body: tabs[provider.selectedIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddEventScreen.routeName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(Icons.add, color: Colors.white, size: 35),
          ),
        );
      },
    );
  }

  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
}