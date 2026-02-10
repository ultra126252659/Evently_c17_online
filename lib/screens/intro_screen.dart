import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/core/extensions.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/onbordingscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//    ? Theme.of(context).colorScheme.onSecondary
//                                   : Theme.of(context).colorScheme.primary,
class IntroScreen extends StatefulWidget {
  static const String routeName = "IntroScreen";

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    // لتسهيل الوصول للون الأساسي
    var primaryColor = context.theme().colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/image logo.png")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              context.brightness() == Brightness.light
                  ? "assets/images/being-creative.png"
                  : "assets/images/being-creative .dark.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text("onboardTitle".tr(), style: context.bodyLarge()),
            Text("onboardText".tr(), style: context.displayMedium()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "language".tr(),
                  style: context.theme().textTheme.displaySmall,
                ),
                Row(
                  children: [
                    // English
                    InkWell(
                      onTap: () {
                        context.setLocale(const Locale("en", "US"));
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 80,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.locale.languageCode == "en"
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "English",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.locale.languageCode == "en"
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Arabic
                    InkWell(
                      onTap: () {
                        context.setLocale(const Locale("ar", "EG"));
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 80,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.locale.languageCode == "ar"
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Arabic",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.locale.languageCode == "ar"
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "theme".tr(),
                  style: context.theme().textTheme.displaySmall,
                ),
                Row(
                  children: [
                    // Light
                    InkWell(
                      onTap: () {
                        provider.changeTheme(ThemeMode.light);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 44,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: provider.themeMode == ThemeMode.light
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.light_mode,
                          size: 20,
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Dark
                    InkWell(
                      onTap: () {
                        provider.changeTheme(ThemeMode.dark);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 44,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: provider.themeMode == ThemeMode.dark
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.dark_mode,
                          size: 20,
                          color: provider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),




            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Onbordingscreen.routeName,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "letsGo".tr(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}