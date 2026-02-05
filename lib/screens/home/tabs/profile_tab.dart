import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/core/firebase_functions.dart';
import 'package:evently_fluttter/providers/auth_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/auth/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        spacing: 20,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset(
              "assets/images/route.profile.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Text(
                authProvider.userModel?.name ?? "",
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,


                ),
              ),
              Text(
                authProvider.userModel?.email ?? "",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,


                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "darkmode".tr(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,


                    ),
                  ),
                ),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    if (themeProvider.themeMode == ThemeMode.light) {
                      themeProvider.changeTheme(ThemeMode.dark);
                    } else {
                      themeProvider.changeTheme(ThemeMode.light);
                    }
                  },
                  activeThumbImage:
                  AssetImage("assets/images/sun.png"),
                  activeColor:
                  Theme.of(context).colorScheme.primary,
                  inactiveThumbImage:
                  AssetImage("assets/images/moon.png"),
                  inactiveTrackColor:
                  Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                   "lung".tr(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,


                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (context.locale.languageCode == 'en') {
                      context.setLocale(
                          const Locale('ar', 'EG'));
                    } else {
                      context.setLocale(
                          const Locale('en', 'US'));
                    }
                  },
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode == ThemeMode.light
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.primary,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Text(
                      context.locale.languageCode == 'en'
                          ? "En"
                          : "Ar",
                      style: TextStyle(
                        fontSize: 20,
                        color: themeProvider.themeMode ==
                            ThemeMode.light
                            ? Theme.of(context)
                            .colorScheme
                            .onSecondary
                            : Theme.of(context)
                            .colorScheme
                            .onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "logOut".tr(),
                    style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseFunctions.signOut();
                    Navigator.pushNamed(
                        context, LoginScreen.routeName);
                  },
                  icon: Image.asset(
                    "assets/images/logout.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
