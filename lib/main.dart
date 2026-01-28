import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/intro_screen.dart';
import 'package:evently_fluttter/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/my_theme_data.dart';



void main() async {
  // 1. ضمان تهيئة Flutter و EasyLocalization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // 2. تشغيل التطبيق
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      // 3. وضع الـ Provider كـ child للـ Localization
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
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

      routes: {
        IntroScreen.routeName: (c) => IntroScreen(),
        Introductionscreens.routeName: (context) => Introductionscreens(),

      },
    );
  }
}
