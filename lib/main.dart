import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/edit/edit_Screen.dart';
import 'package:evently_fluttter/providers/auth_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/add_event/add_event_screen.dart';
import 'package:evently_fluttter/screens/auth/login_screen.dart';
import 'package:evently_fluttter/screens/auth/register_screen.dart';
import 'package:evently_fluttter/screens/auth/reset_password_screen.dart';
import 'package:evently_fluttter/screens/detils_event/detalis_event_screen.dart';
import 'package:evently_fluttter/screens/home/home_screen.dart';
import 'package:evently_fluttter/screens/intro_screen.dart';
import 'package:evently_fluttter/screens/onbordingscreen.dart';
import 'package:evently_fluttter/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'core/my_theme_data.dart';
import 'firebase_options.dart';

// extension StringToInt on String {
//   int toIntOrZero() {
//     return int.tryParse(this) ?? 0;
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التأكد من عدم تهيئة Firebase أكثر من مرة
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    Firebase.app(); // استخدام النسخة الموجودة بالفعل
  }
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();


  await FirebaseFirestore.instance.enableNetwork();




  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.themeMode,
      initialRoute:  Splashscreen.routeName,
      routes: {
        Splashscreen.routeName: (c) => Splashscreen(),
        IntroScreen.routeName: (c) => IntroScreen(),
        Onbordingscreen.routeName: (c) => Onbordingscreen(),
        LoginScreen.routeName: (c) =>  LoginScreen(),
        RegisterScreen.routeName: (c) =>  RegisterScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
        ResetPasswordScreen.routeName: (c) =>  ResetPasswordScreen(),
        AddEventScreen.routeName: (c) => AddEventScreen(),
        DetailsEventScreen.routeName: (c) => DetailsEventScreen(),
        EditScreen.routeName: (c) => EditScreen(),
      },
    );
  }
}