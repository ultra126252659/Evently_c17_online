import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import '../core/cache_helper.dart';
import '../providers/theme_provider.dart';

import 'auth/login_screen.dart';
class Introductionscreens extends StatelessWidget {
  static const String routeName = "Introductionscreen";
  Introductionscreens({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    // تعريف اللون الأساسي للتطبيق عشان نستخدمه في كل مكان (نفس الأزرق اللي في الصور)
    Color primaryBlue = const Color(0xFF5669FF); // أو درجة الأزرق بتاعتك

    late var listPagesViewModel = [
      // الصفحة الأولى: Effortless Event Planning (صورة المكتب)
      PageViewModel(
        titleWidget: Text(
          "Find Events That Inspire You", // أو الترجمة بتاعتك
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: provider.themeMode == ThemeMode.light ? Colors.black : Colors.white
          ),
        ),
        bodyWidget: Text(
          "Dive into a world of events crafted to fit your unique interests...",
          textAlign: TextAlign.center,
          style: TextStyle(color: provider.themeMode == ThemeMode.light ? Colors.black54 : Colors.grey),
        ),
        image: Image.asset(
          provider.themeMode == ThemeMode.light
              ? "assets/images/hot-trending.png"
              : "assets/images/hot-trending (1).png",
          height: 300, // تحجيم الصورة عشان متضربش
        ),
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 40),
        ),
      ),

      // الصفحة الثانية: Connect with Friends (صورة الـ Social)
      PageViewModel(
        titleWidget: Text(
          "Effortless Event Planning",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: provider.themeMode == ThemeMode.light ? Colors.black : Colors.white
          ),
        ),
        bodyWidget: Text(
          "Take the hassle out of organizing events with our all-in-one planning tools...",
          textAlign: TextAlign.center,
          style: TextStyle(color: provider.themeMode == ThemeMode.light ? Colors.black54 : Colors.grey),
        ),
        image: Image.asset(
          provider.themeMode == ThemeMode.light
              ? "assets/images/manager-desk.png"
              : "assets/images/being-creative (1).png",
          height: 300,
        ),
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 40),
        ),
      ),

      // الصفحة الثالثة: Personalize (فيها الشغل كله - اللغة والثيم)
      PageViewModel(
        titleWidget: Text(
          "Personalize Your Experience",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: provider.themeMode == ThemeMode.light ? Colors.black : Colors.white
          ),
        ),
        // هنا عملنا Body مخصص عشان نحط فيه زراير اللغة والثيم
        bodyWidget: Column(
          children: [
            Text(
              "Choose your preferred theme and language to get started...",
              textAlign: TextAlign.center,
              style: TextStyle(color: provider.themeMode == ThemeMode.light ? Colors.black54 : Colors.grey),
            ),
            const SizedBox(height: 20),

            // --- قسم اللغة ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language", style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.w500)),
                // مثال بسيط لزرار التغيير (ممكن تستخدم Dropdown أو Toggle)
                ToggleButtons(
                  isSelected: [context.locale.languageCode == 'en', context.locale.languageCode == 'ar'],
                  onPressed: (int index) {
                    // منطق تغيير اللغة
                    if (index == 0) context.setLocale(const Locale('en'));
                    else context.setLocale(const Locale('ar'));
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: primaryBlue,
                  children: const [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("EN")),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("AR")),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- قسم الثيم ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme", style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.w500)),
                ToggleButtons(
                  isSelected: [provider.themeMode == ThemeMode.light, provider.themeMode == ThemeMode.dark],
                  onPressed: (int index) {

                    provider.changeTheme(index == 0 ? ThemeMode.light : ThemeMode.dark);
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: primaryBlue,
                  children: const [
                    Icon(Icons.wb_sunny_outlined),
                    Icon(Icons.nightlight_round),
                  ],
                ),
              ],
            ),
          ],
        ),
        image: Image.asset(
          provider.themeMode == ThemeMode.light
              ? "assets/images/being-creative.png"
              : "assets/images/being-creative (2).png",
          height: 300,
        ),
        decoration: const PageDecoration(
          imagePadding: EdgeInsets.only(top: 40),
        ),
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0), // مسافة عشان الـ Header ميكونش لازق فوق
        child: IntroductionScreen(
          globalBackgroundColor: provider.themeMode == ThemeMode.light ? Colors.white : const Color(0xFF101127),

          // اللوجو ثابت فوق
          globalHeader: Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Image.asset("assets/images/Evently.png", height: 50),
            ),
          ),

          pages: listPagesViewModel,

          // --- تظبيط الزراير السفلية ---
          showSkipButton: true,
          skip: Text("Skip", style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),

          showNextButton: true,
          next: Icon(Icons.arrow_forward, color: primaryBlue),

          showDoneButton: true,
          done: Text("Let's Start", style: TextStyle(fontWeight: FontWeight.w600, color: primaryBlue)),

          showBackButton: true,
          back: Icon(Icons.arrow_back, color: primaryBlue),

          // --- تظبيط النقاط (Dots) ---
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: primaryBlue, // اللون الأزرق النشط
            color: Colors.grey, // اللون الرمادي لغير النشط
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),

          onSkip: () async {
            await CacheHelper.saveBool(true);
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          onDone: () async {
            await CacheHelper.saveBool(true);
            Navigator.pushReplacementNamed(
                context,
                /* CacheHelper.getBool("intro") == true
            ?*/ LoginScreen.routeName
              /*: Auth.routeName,*/
            );
          },
        ),
      ),
    );

  }

}