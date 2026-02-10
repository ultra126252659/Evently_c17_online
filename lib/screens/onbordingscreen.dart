import 'package:easy_localization/easy_localization.dart';
import 'package:evently_fluttter/providers/theme_provider.dart';
import 'package:evently_fluttter/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Onbordingscreen extends StatefulWidget {
  static const String routeName = "Introductionscreen";

  const Onbordingscreen({super.key});

  @override
  State<Onbordingscreen> createState() => _OnbordingscreenState();
}

class _OnbordingscreenState extends State<Onbordingscreen> {
  // مفتاح للتحكم في التنقل بين الصفحات
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);


    Color primaryBlue = const Color(0xFF02369C);
    Color activeDotColor = const Color(0xFF02369C);
    Color inactiveDotColor = Colors.grey;
    Color textColor = provider.themeMode == ThemeMode.light ? const Color(0xFF1C1C1C) : Colors.white;
    Color subTextColor = provider.themeMode == ThemeMode.light ? const Color(0xFF5F5F5F) : Colors.grey;
    Color scaffoldBg = provider.themeMode == ThemeMode.light ? Colors.white : const Color(0xFF121212);


    PageViewModel createPage({
      required String title,
      required String body,
      required String imagePath,
    }) {
      return PageViewModel(
        titleWidget: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        bodyWidget: Text(
          body,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: subTextColor,
          ),
        ),
        image: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            imagePath,
            height: 300,
            fit: BoxFit.contain,
          ),
        ),
        decoration: PageDecoration(
          pageColor: scaffoldBg,
          imagePadding: const EdgeInsets.only(top: 20, bottom: 20),
          contentMargin: const EdgeInsets.symmetric(horizontal: 24),
          titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 0),
          bodyPadding: const EdgeInsets.only(left: 24, right: 24),
          bodyAlignment: Alignment.topLeft,
          imageAlignment: Alignment.bottomCenter,
        ),
      );
    }

    var pages = [
      createPage(
        title: "onboardTitle1".tr(),
        body: "onboardText1".tr(),

        imagePath:provider.themeMode == ThemeMode.light

            ? "assets/images/hot-trending.png"

            : "assets/images/hot-trending.dark.png",
      ),
      createPage(
        title: "onboardTitle2".tr(),
        body: "onboardText2".tr(),
        imagePath: provider.themeMode == ThemeMode.light
            ? "assets/images/being-creative2.png" 
            : "assets/images/being-creative2.dark.png",
      ),
      createPage(
        title: "onboardTitle3".tr(),
        body: "onboardText3".tr(),
        imagePath: provider.themeMode == ThemeMode.light
            ? "assets/images/being-creative3.png"
            : "assets/images/being-creative.dark3.png",
      ),

    ];

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: () {
                     Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 20, color: textColor),
                    ),
                  ),


               Center(

                   child: Image.asset("assets/images/image logo.png")),

                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);

                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: provider.themeMode == ThemeMode.light ? Colors.grey.shade100 : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: IntroductionScreen(
                key: introKey,
                globalBackgroundColor: scaffoldBg,
                pages: pages,
                showSkipButton: false,
                showNextButton: false,
                showDoneButton: false,
                showBackButton: false,

                globalFooter: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {

                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(26.0, 10.0),
                  activeColor: activeDotColor,
                  color: inactiveDotColor,
                  spacing: const EdgeInsets.symmetric(horizontal: 4.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),

                controlsPadding: const EdgeInsets.only(bottom: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}