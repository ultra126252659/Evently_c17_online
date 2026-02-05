import 'package:evently_fluttter/core/my_theme_data.dart';
import 'package:evently_fluttter/providers/auth_provider.dart';
import 'package:evently_fluttter/providers/home_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/add_event/add_event_screen.dart';
import 'package:evently_fluttter/screens/home/tabs/favorite_tab.dart';
import 'package:evently_fluttter/screens/home/tabs/home_tab..dart';
import 'package:evently_fluttter/screens/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var provider = Provider.of<HomeProvider>(context);
        var themeProvider  = Provider.of<ThemeProvider>(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              ImageIcon(
                AssetImage("assets/images/sun.png"),
                color:themeProvider.themeMode == ThemeMode.light
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.primary,
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
                authProvider.userModel?.name ?? "",
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
                icon: ImageIcon(AssetImage(
                  provider.selectedIndex == 0

                        ?"assets/images/home_select.png"
                        : "assets/images/home.png",

                )),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage(
                    provider.selectedIndex == 1
                    ?"assets/images/heart_select.png"
                        :"assets/images/heart (1).png"

                )),
                label: "Favorite",
              ),

              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage(
                    provider.selectedIndex == 2

                        ?"assets/images/user_select.png"
                :"assets/images/user (1).png"
                )),
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