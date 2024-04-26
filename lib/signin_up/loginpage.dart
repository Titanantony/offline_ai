import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/const/custom_button.dart';
import 'package:offline_ai/const/custom_text.dart';
import 'package:offline_ai/const/custom_text_field.dart';
import 'package:offline_ai/utils/pref.dart';

Preferences mypref = Preferences();

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: CustomText(
                    text: "Sign in",
                    fontsize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: email,
              prefixIcon: const Icon(CupertinoIcons.mail),
              hintText: "email",
            ),
            CustomTextField(
              controller: password,
              prefixIcon: const Icon(CupertinoIcons.lock),
              suffixIcon: const Icon(Icons.visibility),
              hintText: "password",
              obscureText: true,
            ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(backgroundColor: othercolor),
            //     onPressed: login,
            //     child: const Text(
            //       "Sign In",
            //       style: TextStyle(color: primarycolor),
            //     )),
            CustomButton(
              label: "sign in",
              action: login,
              size: const Size(250, 40),
              backgroundcolor: othercolor,
              forecolor: primarycolor,
            ),
            GestureDetector(
              onTap: signup, // Navigate to create account page
              child: const CustomText(
                text: "Don't have an account? Create one",
                textcolor: othercolor,
                fontsize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ));
  }

  void login() {
    Get.toNamed("/home");
  }

  void signup() {
    Get.offAndToNamed("/signup");
  }
}
