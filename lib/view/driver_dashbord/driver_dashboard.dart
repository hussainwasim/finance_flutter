import 'dart:convert';

import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/admin_dashbord/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../admin_dashbord/add_customer.dart';
import 'collection_list.dart';
import 'package:http/http.dart' as http;

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  @override
  Map _userData = {};
  // _fetchUserData() async {
  //   var data = jsonDecode(
  //       StorageHelper.instance.getString(StorageHelperString.loginUserData) ??
  //           "");
  //   setState(() {
  //     _userData = data['user'];
  //     // print(_userData['designation']);
  //   });
  // }

  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchUserData();
    _fetchDashboardStats();
  }

  Map _dashboardData = {};
  // Map _dashboardUser = {};
  bool _isLoading = false;

  _fetchDashboardStats() async {
    setState(() {
      _isLoading = true;
    });
    // var loginResponse = await _storage.read(key: 'LOGIN_RESS');
    String url = 'http://product.artsify.in/public/api/dashboard/';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDAwY2NhZWRiZjcwOWJkNDgxNmY2ZDVhMWIxZjUxOTlmYmYxZjc4MDRjYjgxMzI3YzdmMmMxYWQyMjJkY2JjNGIwNTI1M2JhZjczZWU3ZTIiLCJpYXQiOjE2ODcwNzg3MzkuMzM2OTQ2MDEwNTg5NTk5NjA5Mzc1LCJuYmYiOjE2ODcwNzg3MzkuMzM2OTQ3OTE3OTM4MjMyNDIxODc1LCJleHAiOjE3MTg3MDExMzkuMzI3MjU1OTY0Mjc5MTc0ODA0Njg3NSwic3ViIjoiMiIsInNjb3BlcyI6W119.EVGef-z4ur3eBCB_NPMbYDrF16i9uZ1CP-JFijyy4eQv5HvKY9Gt3GBeXotRRO_nm2I5-RUYfvYhc6XIRfF1HqvTyUc6Tw2vuXzb-0FWzD6uMeZ05dN8CXlIXX_8Uce-xUpZHjjSD7EVVsi1kIdzfvhr7YYeoLcIXw6wceayq8DdU8uAT0yWFabvdOq_TzJb3d2l735_I9CDgiMwTMnwUesX2_InBo-IVqWJ5CqYn1zf7mO-KmW0kTbWq2Gx6MqXv0ZMZeM0MCEDAVW_AenVdq70SQyGpdTIQTZevYR3GaRz3t2Gb46nOdR3HaD5ZX8kitupGlnbtkntVn2UqyfAjcZrhOicIeblDV0C_JFn6lORmxhfUoNG02Hwu6W7-P5gEx-nHcn63VOSgCRRlLnOYLfpgzEu6FBJ0_hO4BxQgz7UuIxfT9pToYIqxm4otvMHIbAnFpqXkJYMXVWNg7QVi852vPm0DbSZHxpBQI2FByGDh-N5aQukOmOf2cNr_SiEiCS-Kx-8RheJQeZhIDsjnA6GqG9S1uOcR7WqlqTdp_q4IFGGEPwUOowR7-VAgiOyOkIjYltUDSUxWzMcu9nTbojb4wG_JUosNEO6b4_3WfyigxrlX85OnA2zww3kXUksAO3ndkUSlNMJvTMvAyuYlLROGiGoi-5MZvlFyjguZb8'
    };
    var response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      Map resBodyMap = jsonDecode(response.body);
      setState(() {
        _dashboardData = resBodyMap['data'];
        //_dashboardUser = resBodyMap['user'];
        _isLoading = false;
        print(_dashboardData);
      });
    } else {
      print(response.statusCode);
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.network(
              'https://cdn.dribbble.com/users/1176657/screenshots/15468294/media/34af996ddff444391edab94abcf3c7f3.png?compress=1&resize=300x300',
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
        title: Text(
          "Hi! ${_dashboardData['user']}",
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textPrimary,
          )),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCustomer()));
              },
              child: Image.asset('assets/images/image 1.png')),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
        child: Column(
          children: [
            Container(
              height: 93,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Attendence",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primaryWhite,
                          ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Check In",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                              Text(
                                "10.30 am",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Check Out",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                              Text(
                                "7.30 pm",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 62,
                    height: 62,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/punchin.png')),
                        Text(
                          "Check In",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 7,
                            color: Color(0xFF424242),
                          )),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryWhite),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Total Collection Amount",
                        style: TextStyle(
                            color: Color(0xFFB2B2B4),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                                text: "₹ ${_dashboardData['totalCollection']}",
                                style: TextStyle(color: Color(0xFF000000))),
                            TextSpan(
                                text: ".00/-",
                                style: TextStyle(color: Color(0xFFB1B1B1))),
                            TextSpan(
                              text: "Year",
                              style: TextStyle(
                                  color: Color(0xFFB1B1B1), fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: SizeConfig.screenWidth! / 2.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Target Collection",
                            style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Text("₹ ${_dashboardData['targetCollection']}",
                            style: TextStyle(
                                color: Color(0xFFFF7E7E),
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFE3E9F0),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Container(
                    height: 80,
                    width: SizeConfig.screenWidth! / 2.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Today Collection",
                            style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Text("₹  ${_dashboardData['totalCollection']}",
                            style: TextStyle(
                                color: Color(0xFF6DC576),
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFE3E9F0),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "COLLECTION LIST",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: textPrimary,
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  CustomerList()),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Click here",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Color(0xFF424242),
                            )),
                          ),
                          Image.asset('assets/images/image 3.png')
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFDEDFFF),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: lightColor, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFB7B8DC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFB7DDD2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDBEA9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
