import 'dart:convert';

import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
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
  Map _dashboardUser = {};
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
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzEwNjMxYTgwNjA0ZDFiZTkxZTRjMWJiZTE2OWJlYTJlMDAxNjUxYzQ3M2RlZTFlNDNhZjkyMmIzZTgyZDNhMjQ5MjJjMDkwYTM3MjBiNjYiLCJpYXQiOjE2ODY5MDcyOTYuMjc2OTE1MDczMzk0Nzc1MzkwNjI1LCJuYmYiOjE2ODY5MDcyOTYuMjc2OTE3OTM0NDE3NzI0NjA5Mzc1LCJleHAiOjE3MTg1Mjk2OTYuMjY5NjcwMDA5NjEzMDM3MTA5Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.AiQVwVNOaEpSC0HZOfRdZdyHPTXK8MH4Q_Zubmf2Ea6VtT1hpE7YTqsIsS8P2QFgmd0BVGt9jRvf7kHMsCwIVXk5f9DE93cr9arAuKgT8P93a5q7mDD14Oa9c8fPlWI1eNR28fM3dK5b_o09qqk6o4ybvqQIUEbUA2Cc8NUzMtod7XE1zcqYWzsOcs1omrnwTEsKblPHg53f_-s1e4vFz7ACw3i51gtMtqs8ZPi4_jprzp2kNKw0gCyEZb_Xv6n7YKoW3wIIQOHLdNeOrM6dkbbqBZ6W_JyE8Bs44DAcQgmqIvW8w9BFQ9nI9phGBpr25A0ZrvIXc0wXAKUMcRVG9QOchTOM0pLLXZLnLJ4cHIvyF9ES423QWovYvfRtCvqehsLdJiKdEiCuu-96EETeq9xieAPVfhwl_iiIQ5trAG4QArZJ6rnhYvOriTgu9ffOwb4R8C_W1kl-tMmehyUPbnHHm4CpVm54DFXdqPAhVDsog0HUa7YYeVt0P6XHjMjNFLtIlSvOssTezbs87Z5b0DDxXjG96yKZqdgVCwZbNAGJS2TGQif8M_ijVJezpC-2OlIBBUZqiUE6dsp4au_BGpFOPQQC3IdnY0twUCZ5RxXpvNttWO7BVbRNxEbtZsmYkTRlV-__FqqgIVJ46WZlMdyREaMaC6IT_LOzol_bzjs'
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
          "Hi!${_dashboardData}",
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
                                text: "₹ 12,05,000",
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
                        Text("₹ 1200000",
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
                        Text("₹ 1200000",
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
                            builder: (context) => const CollectionList()),
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
