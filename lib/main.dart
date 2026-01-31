import 'package:evently_fluttter/providers/auth_provider.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/addevent/add_event_screen.dart';

import 'package:evently_fluttter/screens/auth/login_screen.dart';
import 'package:evently_fluttter/screens/auth/register_screen.dart';
import 'package:evently_fluttter/screens/auth/reset_password_screen.dart';
import 'package:evently_fluttter/screens/intro_screen.dart';
import 'package:evently_fluttter/screens/OnboardingScreen.dart';
import 'package:evently_fluttter/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/home_screen.dart';
import 'core/cache_helper.dart';
import 'core/my_theme_data.dart';



void main() async {
  // 1. ضمان تهيئة Flutter و EasyLocalization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  // 2. تشغيل التطبيق
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      // 3. وضع الـ Provider كـ child للـ Localization
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> ThemeProvider()),
          ChangeNotifierProvider(create: (context)=> AuthProvider())
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
    // استقبال البروفايدر
    var provider = Provider.of<ThemeProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      // إعدادات اللغة
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,

      // إعدادات الثيم
      theme: MyThemeData.lightTheme, // تأكد من وجود كلاس MyThemeData
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.themeMode, // نستخدم القيمة القادمة من البروفايدر فقط

      // إعدادات الراوت (التنقل)
      initialRoute: Splashscreen.routeName,
      routes: {

        Splashscreen.routeName:(c) =>Splashscreen (),
        IntroScreen.routeName: (c) => IntroScreen(),
        Introductionscreens.routeName: (c) => Introductionscreens(),
        LoginScreen.routeName: (c) => const LoginScreen(),
        RegisterScreen.routeName: (c) => const RegisterScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
        ResetPasswordScreen.routeName: (c) => const ResetPasswordScreen(),
        AddEventScreen.routeName: (c) =>  AddEventScreen(),


      },
    );
  }
}
