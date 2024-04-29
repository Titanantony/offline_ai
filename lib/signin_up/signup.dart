import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/const/custom_button.dart';
import 'package:offline_ai/const/custom_text.dart';
import 'package:offline_ai/const/custom_text_field.dart';
import 'package:offline_ai/utils/pref.dart';
import 'package:http/http.dart' as http;

Preferences mypref = Preferences();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  text: "Sign up",
                  fontsize: 34,
                  fontWeight: FontWeight.bold,
                  textcolor: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _nameController,
            prefixIcon: const Icon(CupertinoIcons.person_crop_circle),
            hintText: "name",
            hintcolor: Colors.black,
          ),
          CustomTextField(
            controller: _emailController,
            prefixIcon: const Icon(CupertinoIcons.mail),
            hintText: "email",
          ),
          CustomTextField(
            controller: _passwordController,
            prefixIcon: const Icon(CupertinoIcons.lock),
            isPassword: true,
            hintText: "password",
          ),
          CustomButton(
            label: "sign up",
            action: serverSignup,
            size: const Size(250, 40),
            backgroundcolor: othercolor,
            forecolor: primarycolor,
          ),
          GestureDetector(
            onTap: _signIn,
            child: const CustomText(
              text: "Already have an account? Sign in",
              textcolor: othercolor,
              fontsize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    // Add your sign-up logic here
  }

  void _signIn() {
    // Navigate to sign in page
    Get.offAndToNamed("/login");
  }

  Future<void> serverSignup() async {
    http.Response response;
    var body = {
      'username': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    response = await http
        .post(Uri.parse("https://nattiee.com/MrcyAI/signup.php"), body: body);
    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      int signedUp = serverResponse['success'];
      if (signedUp == 1) {
        Get.offAndToNamed("/login");
        print("account created");
      } else {
        print("Account not created");
      }
    }
  }
}
