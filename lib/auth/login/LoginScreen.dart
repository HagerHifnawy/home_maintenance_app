import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_maintenance/auth/signup/SignupScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/home/HomeScreen.dart';
import 'package:home_maintenance/main.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    super.initState();
  }

  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      body: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _loginFormKey,
            child: ListView(children: [
              //LOGO
              Container(
                  child: Center(child: Image.asset('assets/images/logo.png'))),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 25)),
                    Text(
                      'Welcome!',
                      style: GoogleFonts.raleway(
                          fontSize: 30, color: MyThemeData.lightBlue),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25)),
                    TextFormField(
                      onChanged: (newValue) {
                        _emailController.text = newValue;
                      },
                      style: GoogleFonts.raleway(color: MyThemeData.lightBlue),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyThemeData.lightBlue)),
                          hintText: 'Please,Confirm Your Email',
                          suffixIcon: Icon(
                            Icons.email,
                            color: MyThemeData.lightBlue,
                          ),
                          hintStyle: TextStyle(color: MyThemeData.lightBlue),
                          labelStyle: TextStyle(color: MyThemeData.lightBlue),
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: MyThemeData.lightBlue),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please,Confirm Your Email';
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 25)),
                    TextFormField(
                      obscureText: isHiddenPassword,
                      onChanged: (newValue) {
                        _passwordController.text = newValue;
                      },
                      style: GoogleFonts.raleway(color: MyThemeData.lightBlue),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyThemeData.lightBlue)),
                          hintText: 'Please,Confirm Your Password',
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: isHiddenPassword
                                  ? 'hide password'
                                  : 'show password',
                              color: MyThemeData.lightBlue,
                            ),
                          ),
                          hintStyle: TextStyle(color: MyThemeData.lightBlue),
                          labelStyle: TextStyle(color: MyThemeData.lightBlue),
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: MyThemeData.lightBlue),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please,Confirm Your Password';
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 25)),
                    ElevatedButton(
                      onPressed: login,
                      child: Text(
                        'Log In',
                        style: GoogleFonts.raleway(),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: MyThemeData.lightBlue),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextButton(
                      onPressed: onClick,
                      child: Text(
                        'Create New Account.',
                        style: GoogleFonts.raleway(
                          color: MyThemeData.lightBlue,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )),
    );
  }

  bool isHiddenPassword = true;
  bool isLoading = false;

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    if (_loginFormKey.currentState?.validate() == true) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        // pushReplacement
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        showErrorMessage(e.message ?? 'some thing went wrong please try again');
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  void login() async {
    if (_loginFormKey.currentState.validate() == true) {
      signIn();
    }
  }

  void onClick() async {
    Navigator.pushNamed(context, SignupScreen.routeName);
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
