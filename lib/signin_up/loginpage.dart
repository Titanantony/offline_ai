import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/const/custom_button.dart';
import 'package:offline_ai/const/custom_text.dart';
import 'package:offline_ai/const/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
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
                  text: "Sign in",
                  fontsize: 34,
                  fontWeight: FontWeight.bold,
                  textcolor: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _emailController,
            prefixIcon: const Icon(CupertinoIcons.mail),
            hintText: "Email",
            hintcolor: Colors.black,
          ),
          CustomTextField(
            controller: _passwordController,
            prefixIcon: const Icon(CupertinoIcons.lock),
            hintText: "Password",
            isPassword: true,
          ),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  label: "Sign In",
                  action: remoteLogin,
                  size: const Size(250, 40),
                  backgroundcolor: othercolor,
                  forecolor: primarycolor,
                ),
          GestureDetector(
            onTap: signUp,
            child: const CustomText(
              text: "Don't have an account? Create one",
              textcolor: othercolor,
              fontsize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> remoteLogin() async {
    setState(() {
      isLoading = true;
    });

    http.Response response;
    response = await http.get(Uri.parse(
        "http://nattiee.com/MrcyAI/login.php?email=${_emailController.text.trim()}&password=${_passwordController.text.trim()}"));

    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      var loginServer = serverResponse['success'];
      if (loginServer == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful'),
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          Get.offAndToNamed("/");
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Login Error: Invalid email or password'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } else {
      print("error ${response.statusCode}");
    }

    setState(() {
      isLoading = false;
    });
  }

  void signUp() {
    Get.offAndToNamed("/signup");
  }
}
