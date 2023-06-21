import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/res/style/colors.dart';
import 'package:fin/view/admin_dashbord/add_employee.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'add_customer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  static const storage = FlutterSecureStorage();
  Map _dashboardData = {};
  // Map _dashboardUser = {};
  bool _isLoading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchUserData();
    _fetchDashboardStats();
  }

  _fetchDashboardStats() async {
    setState(() {
      _isLoading = true;
    });
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    String url = 'http://product.artsify.in/public/api/dashboard/';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipOval(
            child: Image.network(
              'https://cdn.dribbble.com/users/1176657/screenshots/15468294/media/34af996ddff444391edab94abcf3c7f3.png?compress=1&resize=300x300',
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
        title: Text(
          "Hi! ${_dashboardData["user"]}",
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
                    MaterialPageRoute(builder: (context) => AddEmployee()));
              },
              child: Image.asset('assets/images/add_emp.png')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    height: 124,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Your Total Investment",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: primaryWhite,
                              ))),
                          SizedBox(
                            height: 10,
                          ),
                          Text("₹ ${_dashboardData['totalInvestment'] ?? 0}",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 29,
                                color: primaryWhite,
                              ))),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      height: 48,
                      width: 350,
                      decoration: BoxDecoration(
                        color: primaryWhite,
                        borderRadius: BorderRadius.circular(61),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        // boxShadow: BoxShadow.lerp(0, 20, 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Pending :",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFF777881),
                                ))),
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  child: Text(
                                      "₹ ${_dashboardData['pending'] ?? 0}",
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: primaryColor,
                                      ))),
                                ),
                                TextSpan(
                                  text: "+ ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: textPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  child: Text("Including",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 5,
                                        color: Color(0xFF777881),
                                      ))),
                                ),
                                TextSpan(
                                    text: "\nInterest",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 9,
                                      color: Color(0xFFFF7E7E),
                                    ))),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  shape: BoxShape.circle),
                              child: Image.asset('assets/images/yesterday.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Yesterday ",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                      color: textPrimary,
                                    ))),
                                Text("Collection",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 7,
                                      color: textPrimary,
                                    ))),
                              ],
                            ),
                          ],
                        ),
                        Image.asset('assets/images/Vector.png'),
                        Container(
                          height: 21,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                                "₹ ${_dashboardData['yesterDayCollection'] ?? 0}",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: textPrimary,
                                ))),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A21311A),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFB7DDD2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  shape: BoxShape.circle),
                              child: Image.asset('assets/images/date.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Today ",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                      color: textPrimary,
                                    ))),
                                Text("Collection",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 7,
                                      color: textPrimary,
                                    ))),
                              ],
                            ),
                          ],
                        ),
                        Image.asset('assets/images/Vector.png'),
                        Container(
                          height: 21,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                                "₹ ${_dashboardData['toDayCollection'] ?? 0}",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: textPrimary,
                                ))),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A21311A),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDBEA9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  shape: BoxShape.circle),
                              child: Image.asset('assets/images/tomorrow.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tommorow ",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                      color: textPrimary,
                                    ))),
                                Text("Target",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 7,
                                      color: textPrimary,
                                    ))),
                              ],
                            ),
                          ],
                        ),
                        Image.asset('assets/images/Vector.png'),
                        Container(
                          height: 21,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                                "₹ ${_dashboardData['tommorowTarget'] ?? 0} ",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: textPrimary,
                                ))),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A21311A),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Text("Total Net Amount",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFFB2B2B4),
                        ))),
                  ),
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Row(
                      children: [
                        Text("₹ ${_dashboardData['netAmount']}",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              color: textPrimary,
                            ))),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Text(".00 /- ",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 35,
                                      color: Color(0xFFB1B1B1),
                                    ))),
                              ),
                              TextSpan(
                                  text: 'Year',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color(0xFF1A2131),
                                  ))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Remarks ",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: textPrimary,
                      ))),
                  TextButton(
                    onPressed: (() {}),
                    child: Text("View all ",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(0xFF737373)))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140,
                child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(
                          width: 12,
                        ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Container(
                        height: 140,
                        width: 309,
                        decoration: BoxDecoration(
                          color: Color(0xFFE3E9F0),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 51,
                                  width: 51,
                                  decoration: BoxDecoration(
                                      color: primaryWhite,
                                      shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://cdn.dribbble.com/users/1176657/screenshots/15468294/media/34af996ddff444391edab94abcf3c7f3.png?compress=1&resize=300x300',
                                      height: 43.0,
                                      width: 43.0,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("S.Vignesh / ",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24,
                                              color: textPrimary,
                                            ))),
                                        Text("10115",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24,
                                              color: Color(0xFF9299A4),
                                            ))),
                                      ],
                                    ),
                                    Text(
                                        "Pudhur,Sankarapuram,Kallakurichi,606801.",
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                          color: textPrimary,
                                        ))),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: primaryWhite,
                              height: 2,
                              thickness: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Note : ",
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                        color: textPrimary,
                                      ))),
                                  Flexible(
                                    child: Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.printing and typesetting industry.',
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: textPrimary,
                                        ))),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}
