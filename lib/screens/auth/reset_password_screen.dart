import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "ResetPassword";

  const ResetPasswordScreen({super.key});

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
            Image.asset("assets/images/reset_password_img.png"),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter your email",
                fillColor: Colors.white,
                filled: true,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                prefixIcon: ImageIcon(
                  AssetImage("assets/images/email_ic.png"),
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}