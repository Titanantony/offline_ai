// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/const/custom_button.dart';
import 'package:offline_ai/const/custom_text.dart';
import 'package:offline_ai/const/custom_text_field.dart';
import 'package:offline_ai/user_auth/firebase_auth_services.dart';
import 'package:offline_ai/utils/pref.dart';

Preferences mypref = Preferences();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuthService _auth = FirebaseAuthService();
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
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _nameController,
            prefixIcon: const Icon(CupertinoIcons.person),
            hintText: "name",
          ),
          CustomTextField(
            controller: _emailController,
            prefixIcon: const Icon(CupertinoIcons.mail),
            hintText: "email",
          ),
          CustomTextField(
            controller: _passwordController,
            prefixIcon: const Icon(CupertinoIcons.lock),
            suffixIcon: const Icon(Icons.visibility),
            hintText: "password",
            obscureText: true,
          ),
          CustomButton(
            label: "sign up",
            action: _signUp,
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

  void _signUp() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Sign up with email and password
      await _auth.createUserWithEmailAndPassword(email, password);

      // Navigate to home page
      Get.toNamed("/home");
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  void _signIn() {
    // Navigate to sign in page
    Get.offAndToNamed("/login");
  }
}
