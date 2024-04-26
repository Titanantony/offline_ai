import 'package:get/get_navigation/src/routes/get_route.dart';
// import 'package:offline_ai/screens/home_screen.dart';
import 'package:offline_ai/nav/topnav.dart';
import 'package:offline_ai/signin_up/loginpage.dart';
import 'package:offline_ai/signin_up/signup.dart';

class Routes {
  static var routes = [
    GetPage(name: "/login", page: () => Login()),
    GetPage(name: "/signup", page: () => Signup()),
    GetPage(name: "/", page: () => MyAppWithBottomNavBar()),
  ];
}
