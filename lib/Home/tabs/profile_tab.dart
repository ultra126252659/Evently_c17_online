import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/StringApp..dart';
import '../../core/firebase_functions.dart';
import '../../core/style_app.dart';



import '../../model/user_model.dart';
import '../../providers/theme_provider.dart';
import '../../screens/auth/login_screen.dart';

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
    return  Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.background,
      child:Column(
        spacing: 20,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset("assets/images/route.profile.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Column(
              children: [
                Text(authProvider.UserModel?.name ?? "",
                  style:StyleApp.titleStyleLocalize,
                ),
                Text(authProvider.UserModel?.email ?? "",
                  style:StyleApp.descriptionStyleLocalize,
                ),
              ]
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
                  Expanded(child: Text("darkmode",
                      style: StyleApp.titleStyleLocalize
                  )),

                  Switch(
                    value: themeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value){
                      if(themeProvider.themeMode == ThemeMode.light){
                        themeProvider.changeTheme(ThemeMode.dark);
                      }else{
                        themeProvider.changeTheme(ThemeMode.light);
                      }
                    },
                    activeThumbImage: AssetImage("assets/images/sun.png"),
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveThumbImage: AssetImage("assets/images/moon.png"),
                    inactiveTrackColor: Theme.of(context).colorScheme.surface ,
                  )

                ]
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
                  Expanded(child: Text(StringApp.language,
                      style: StyleApp.titleStyleLocalize
                  )),
                  GestureDetector(
                    onTap: (){
                      if (context.locale.languageCode == 'en') {
                        context.setLocale(const Locale('ar', 'EG')); // تغيير للعربي
                      } else {
                        context.setLocale(const Locale('en', 'US')); // تغيير للإنجليزي
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(context.locale.languageCode == 'en' ?"En":"Ar",
                          style: TextStyle(
                              fontSize: 20,
                              color:themeProvider.themeMode == ThemeMode.light?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onPrimary
                          )
                      ),
                    ),
                  )

                ]
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
                  Expanded(child: Text("logOut".tr(),
                      style: StyleApp.titleStyleLocalize
                  )),
                  IconButton(
                      onPressed: (){
                        FirebaseFunctions.signOut();
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      icon:  Image.asset("assets/images/logout.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ))

                ]
            ),
          ),


        ],
      ),
    );

  }
}

