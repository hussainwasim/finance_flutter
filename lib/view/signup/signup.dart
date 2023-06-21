import 'dart:convert';

import 'package:fin/models/signup_model.dart';
import 'package:fin/res/style/colors.dart';
import 'package:fin/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../utils/storage_helpers/storage_helpers.dart';
import '../../utils/storage_helpers/storage_helpers_string.dart';
import '../../widgets/snackbar.dart';
import '../admin_dashbord/admin_dashboard.dart';
import '../driver_dashbord/driver_dashboard.dart';
import '../view_model/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  signup() async {
    setState(() {
      isLoading = false;
    });
    print(name.text);
    if (_formKey.currentState!.validate()) {
      await SignUpModel.sign(name.text, mobile.text, password.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.only(top: 25, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Register  ",
                      style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ))),
                  Image.asset('assets/images/User.png'),
                ],
              ),
              Text("Welcome to our Financial App ",
                  style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5B5B5B),
                  ))),
              SizedBox(
                height: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textPrimary,
                          ))),
                      SizedBox(
                        height: 44,
                        child: TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF1F0F3),
                            filled: true,
                            hintText: "Enter your name",
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: textPrimary,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            //border: InputBorder.none
                          ),
                        ),
                      ),
                      Text("Mobile Number",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textPrimary,
                          ))),
                      SizedBox(
                        height: 44,
                        child: TextFormField(
                          controller: mobile,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF1F0F3),
                            filled: true,
                            hintText: "Enter your mobile number",
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: textPrimary,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            //border: InputBorder.none
                          ),
                        ),
                      ),
                      Text("Password",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textPrimary,
                          ))),
                      SizedBox(
                        height: 44,
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF1F0F3),
                            filled: true,
                            hintText: "Enter your Password",
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: textPrimary,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                          ),
                        ),
                      ),
                      Text("Confirm Password",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textPrimary,
                          ))),
                      SizedBox(
                        height: 44,
                        child: TextFormField(
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF1F0F3),
                            filled: true,
                            hintText: "Enter your confirm Password",
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: textPrimary,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(36)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(342, 40),
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("ok");
                  }
                  signup();
                },
                child: Text('Register ',
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primaryWhite,
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 105,
                      child: Divider(
                        thickness: 1,
                        height: 3,
                        color: Color(0xFFA39797),
                      ),
                    ),
                    Text("Or Signup with",
                        style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF757171),
                        ))),
                    Container(
                      width: 105,
                      child: Divider(
                        thickness: 1,
                        height: 3,
                        color: Color(0xFFA39797),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Text("Google",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ))),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: " You have an account ?",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: textPrimary,
                          ))),
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogIn(),
                              ));
                        },
                        child: Text("  Sign in",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ))),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
