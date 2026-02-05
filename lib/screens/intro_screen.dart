import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/core/extensions.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/onbordingscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(title: Image.asset("assets/images/Evently.png")),
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
                  "lung".tr(),
                  style: context.theme().textTheme.displaySmall,
                ),
                Container(
                  padding: const EdgeInsets.all(2), // مسافة صغيرة داخل الإطار
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: primaryColor, width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // English Button
                      InkWell(
                        onTap: () {
                          context.setLocale(Locale("en", "US"));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.locale == Locale("en", "US")
                                ? primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "English",
                            style: context.theme().textTheme.bodyMedium?.copyWith(
                              color: context.locale == Locale("en", "US")
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          context.setLocale(Locale("ar", "EG"));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: context.locale == Locale("ar", "EG")
                         ?   Theme.of(context).colorScheme.onSecondary
                         : Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Arabic",
                            style: context.theme().textTheme.bodyMedium?.copyWith(
                              color: context.locale == Locale("ar", "EG")
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(), style: context.displaySmall()),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Light Mode (Sun)
                      InkWell(
                        onTap: () {
                          provider.changeTheme(ThemeMode.light);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          decoration: BoxDecoration(
                            color: provider.themeMode == ThemeMode.light
                                ? primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ImageIcon(
                            const AssetImage("assets/images/sun.png"),
                            size: 30,
                            color: provider.themeMode == ThemeMode.light
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      // Dark Mode (Moon)
                      InkWell(
                        onTap: () {
                          provider.changeTheme(ThemeMode.dark);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          decoration: BoxDecoration(
                            color: provider.themeMode == ThemeMode.dark
                                ? primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ImageIcon(
                            const AssetImage("assets/images/moon.png"),
                            size: 30,
                            color: provider.themeMode == ThemeMode.dark
                                ? Theme.of(context).colorScheme.onSecondary
                                :Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
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