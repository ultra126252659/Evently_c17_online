import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/cache_helper.dart';
import '../providers/theme_provider.dart';
import 'introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = "IntroScreen";

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    Color activeColor = Color(0xFF1B3893);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
            "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3 (1).png"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            provider.themeMode == ThemeMode.light
                ? Image.asset(
              "assets/images/being-creative.withe.png",
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Image.asset(
              "assets/images/being-creative.black.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              "onboardingTitle".tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "onboardingSubTitle".tr(),
              style: Theme.of(context).textTheme.displayMedium,
            ),

            // ---------------- LANGUAGE TOGGLE ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "language".tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Container(
                  padding: EdgeInsets.all(2), // tiny padding for the border effect
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: activeColor, width: 1),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: context.locale == Locale("en", "US")
                                ? activeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "English",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.locale == Locale("en", "US")
                                  ? Colors.white
                                  : activeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Arabic Button
                      InkWell(
                        onTap: () {
                          context.setLocale(Locale("ar", "EG"));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: context.locale == Locale("ar", "EG")
                                ? activeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Arabic",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.locale == Locale("ar", "EG")
                                  ? Colors.white
                                  : activeColor,
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

            // ---------------- THEME TOGGLE ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "theme".tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: activeColor, width: 1),
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
                                ? activeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/images/sun.png"),
                            size: 30,
                            color: provider.themeMode == ThemeMode.light
                                ? Colors.white
                                : activeColor,
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
                                ? activeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/images/moon.png"),
                            size: 30,
                            color: provider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : activeColor,
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


                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Introductionscreens()),
                  );

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "letsStart".tr(),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white
                    ),
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














