import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_maintenance/AppProvider.dart';
import 'package:home_maintenance/auth/signup/SignupScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/database/databasehelper.dart';
import 'package:home_maintenance/home/HomeScreen.dart';
import 'package:home_maintenance/main.dart';
import 'package:provider/provider.dart';

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
  late AppProvider provider;

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
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
                    isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        :
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
                        'You Don’t Have An Account?Sign Up.',
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
        UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        if(userCredential.user==null){
          showErrorMessage('invalid credentials no user exist''with this email and password');
        }else{
          final userCollectionRef = getUserCollectionsWithConvert();
          userCollectionRef.doc(userCredential.user!.uid)
             .get()
             .then((value) => provider.updateUser(value.data()));
               Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }

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
    if (_loginFormKey.currentState?.validate() == true) {
      signIn();
    }
  }

  void onClick() async {
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
