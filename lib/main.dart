import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_maintenance/AllCategories/categories/CategoryScreen.dart';
import 'package:home_maintenance/AppProvider.dart';
import 'package:home_maintenance/chat/ChatScreen.dart';
import 'package:home_maintenance/comments/CommentsScreen.dart';
import 'package:home_maintenance/home/HomeScreen.dart';
import 'package:home_maintenance/home/location/MapScreen.dart';
import 'package:home_maintenance/lastservices/LastServicesScreen.dart';
import 'package:home_maintenance/rating/RateScreen.dart';
import 'package:home_maintenance/settings/SettingsScreen.dart';
import 'package:provider/provider.dart';
import 'auth/login/LoginScreen.dart';
import 'auth/signup/SignupScreen.dart';

class MyThemeData {
  static var lightBlue = Color.fromRGBO(96, 137, 143, 1.0);
  static var backgroundColor = Color.fromRGBO(213, 216, 216, 1.0);
  static var black = Color.fromRGBO(14, 14, 14, 1.0);
  static var white = Color.fromRGBO(255, 255, 255, 1.0);
  static var pink = Color.fromRGBO(223, 141, 144, 1.0);
  static var blue = Color.fromRGBO(137, 178, 232, 1.0);

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
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context, widget) {
        return MaterialApp(
          title: 'Home Maintenance',
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 96, 137, 143),
            accentColor: Color.fromARGB(255, 14, 14, 14),
          ),
          routes: {
            MapScreen.routeName: (context) => MapScreen(),
            SignupScreen.routeName: (context) => SignupScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            CategoryScreen.routeName: (context) => CategoryScreen(),
            ChatScreen.routeName: (context) => ChatScreen(),
            CommentsScreen.routeName:(context) => CommentsScreen(),
            RateScreen.routeName: (context) => RateScreen(),
            LastServicesScreen.routeName:(context)=> LastServicesScreen(),
            SettingsScreen.routeName:(context)=> SettingsScreen(),
          },
          initialRoute: LoginScreen.routeName,
        );
      },
    );
  }
}
