import 'package:evently_fluttter/core/extensions.dart';
import 'package:evently_fluttter/core/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "ResetPassword";

  ResetPasswordScreen({super.key});

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Image.asset(
                context.brightness() == Brightness.light
                ?"assets/images/change-setting.ligth.png"
                :"assets/images/change-setting.dark.png"
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                fillColor: Colors.white,
                filled: true,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                prefixIcon: ImageIcon(
                  AssetImage("assets/images/sms (1).png"),
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                FirebaseFunctions.resetPassword(emailController.text);
              },
              child: const Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}