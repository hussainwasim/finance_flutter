import 'package:fin/res/style/colors.dart';
import 'package:fin/view/driver_dashbord/driver_dashboard.dart';
import 'package:fin/view/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: EdgeInsets.only(top: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Login  ",
                            style: GoogleFonts.outfit(
                                textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ))),
                        Image.asset('assets/images/User.png'),
                      ],
                    ),
                    Text("Welcome back , Joseph Vicky",
                        style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF5B5B5B),
                        ))),
                  ],
                ),
                Container(
                  child: Image.asset('assets/images/login.png'),
                ),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          decoration: InputDecoration(
                            fillColor: Color(0xFFD9D9D9),
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
                          decoration: InputDecoration(
                            fillColor: Color(0xFFD9D9D9),
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
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment(1, 0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forget Password ? ",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textPrimary,
                        ))),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(342, 40),
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DriverDashboard())));
                  },
                  child: Text('Login ',
                      style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryWhite,
                      ))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 25, right: 25),
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
                      Text("Or Login with",
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: " You Don’t have an account ?",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: textPrimary,
                          ))),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignUp())));
                          }),
                          child: Text("  Sign up",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ))),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
