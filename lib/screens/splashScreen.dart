import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../core/cache_helper.dart';
import '../providers/theme_provider.dart';

import 'auth/login_screen.dart';
import 'intro_screen.dart';

class Splashscreen extends StatefulWidget {
  static const routeName="SplashScreen";
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override

  void initState() {
    super.initState();
    getNext();
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:  provider.themeMode == ThemeMode.light?Colors.white:Colors.black,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3 (1).png",
              width: 200,
              fit: BoxFit.contain,
            ),
          ),


          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Image.asset("assets/images/Logo.png",
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Supervised by Mohamed Nabil',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF202020), // لون نص غامق
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],


            ),
          ),

        ],
      ),


    );
  }

  void getNext() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
       CacheHelper.getBool("intro") == true
            ? IntroScreen.routeName
        : LoginScreen.routeName,
      );
    });
  }
}