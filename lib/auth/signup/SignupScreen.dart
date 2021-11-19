import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/AppProvider.dart';
import 'package:home_maintenance/auth/login/LoginScreen.dart';
import 'package:home_maintenance/auth/signup/model/UserModel.dart';
import 'package:home_maintenance/database/databasehelper.dart';
import 'package:home_maintenance/home/HomeScreen.dart';
import 'package:home_maintenance/main.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  String name = '',
      emailAddress = '',
      address = '',
      phoneNumber = '',
      password = '',
      confirmPassword = '';
late AppProvider provider;
  @override
  Widget build(BuildContext context) {
     provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      body: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _signupFormKey,
            child: ListView(children: [
              //LOGO
              Container(
                  child: Center(child: Image.asset('assets/images/logo.png'))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text('Name', 'Please, Enter Your Name', Icons.person_rounded),
                  text('Email Address', 'Please, Enter Your Email Address',
                      Icons.email),
                  text('Address', 'Please, Enter Your Address',
                      Icons.home_outlined),
                  text('Phone Number', 'Please, Enter Your Phone Number',
                      Icons.phone_enabled_rounded),
                  TextFormField(
                    obscureText: isHiddenPassword,
                    onChanged: (newValue) {
                      password = newValue;
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
                  TextFormField(
                    obscureText: isHiddenPassword,
                    onChanged: (newValue) {
                      confirmPassword = newValue;
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
                        labelText: 'Confirm Password',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        fillColor: MyThemeData.lightBlue),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please,Confirm Your Password';
                      }
                      return null;
                    },
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: createAccount,
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.raleway(),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: MyThemeData.lightBlue),
                        ),
                  TextButton(
                    onPressed: onClick,
                    child: Text(
                      'You Have an Account?Log In',
                      style: GoogleFonts.raleway(
                        color: MyThemeData.lightBlue,
                      ),
                    ),
                  )
                ],
              )
            ]),
          )),
    );
  }

  final dp = FirebaseFirestore.instance;
  text(var text1, text2, icon) {
    var textFormField = TextFormField(
      style: GoogleFonts.raleway(color: MyThemeData.lightBlue),
      onChanged: (newValue) {
        if (text1 == 'Name') {
          name = newValue;
        }
        if (text1 == 'Email Address') {
          emailAddress = newValue;
        }
        if (text1 == 'Address') {
          address = newValue;
        }
        if (text1 == 'Phone Number') {
          phoneNumber = newValue;
        }
      },
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyThemeData.lightBlue)),
          hintText: text2,
          suffixIcon: Icon(
            icon,
            color: MyThemeData.lightBlue,
          ),
          hintStyle: TextStyle(color: MyThemeData.lightBlue),
          labelStyle: TextStyle(color: MyThemeData.lightBlue),
          labelText: text1,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          fillColor: MyThemeData.lightBlue),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return text2;
        }
        return null;
      },
    );
    return textFormField;
  }

  bool isHiddenPassword = true;
  bool isLoading = false;
  void createAccount() {
    if (_signupFormKey.currentState?.validate() == true) {
      signUp();
    }
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      if (password != confirmPassword) {
        showErrorMessage('password does not match');
      } else
        showErrorMessage('User Registered Successfully');
      final userCollectionRef = getUserCollectionsWithConvert();
      final user =userModel(
          name: name,
          emailAddress: emailAddress,
          phoneNumber: phoneNumber,
          address: address,
          uId: userCredential.user!.uid);
      userCollectionRef.doc(user.uId).set(user).then((value){
        //save user
        provider.updateUser(user);
        Navigator.pushReplacementNamed(context,HomeScreen.routeName);

      }
      );
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message ?? 'some thing went wrong please try again');
    } catch (e) {
      print(e);
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

  void onClick() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
