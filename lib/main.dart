import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_maintenance/home/HomeScreen.dart';
import 'auth/login/LoginScreen.dart';
import 'auth/signup/SignupScreen.dart';

class MyThemeData {
  static var lightBlue = Color.fromRGBO(96, 137, 143, 1.0);
  static var backgroundColor = Color.fromRGBO(213, 216, 216, 1.0);
  static var black = Color.fromRGBO(14, 14, 14, 1.0);
  static var white = Color.fromRGBO(255, 255, 255, 1.0);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Maintenance',
      theme: ThemeData(
        primaryColor: MyThemeData.lightBlue,
      ),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
