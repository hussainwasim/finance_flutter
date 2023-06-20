import 'dart:convert';

import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/driver_dashbord/add_fund.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fin/res/style/colors.dart';
import 'package:http/http.dart' as http;

import '../view/admin_dashbord/customer_detail.dart';

class CustomerCard extends StatefulWidget {
  final int? id;
  const CustomerCard({super.key, this.id});

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  bool isLoading = false;
  static const storage = FlutterSecureStorage();
  Map _customerData = {};
  Future getUsers() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    setState(() {
      isLoading = true;
    });
    var url = 'http://product.artsify.in/public/api/customers/' +
        widget.id.toString();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        //customerMap = body;
        _customerData = data['data'];
        isLoading = false;
      });
    } else {
      print(response.body);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 262,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_customerData['name'] ?? ''} / ${_customerData['customer_id'] ?? ''}",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Color(0xFFFCFDFF),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    // Text(
                    //   "South street,pudukottai road, Sankarapuram Taluk,Gingee pincode : 606 604",
                    //   maxLines: 3,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: GoogleFonts.inter(
                    //       textStyle: const TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //     color: primaryWhite,
                    //   )),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset('assets/images/phone.png'),
                Text("\t +91 \t${_customerData['contact_no'] ?? '9876543210'}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: primaryWhite,
                    ))),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/mail.png'),
                Text(
                    "\t ${_customerData['email'] ?? '${_customerData['name']}@gmail.com'}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: primaryWhite,
                    ))),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Finance Amount",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: primaryWhite,
                  )),
                ),
                Text("₹ ${_customerData['loan_amount'] ?? ''}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      color: primaryWhite,
                    ))),
              ],
            ),
            Text("Balance Amount",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: primaryWhite,
                ))),
            Text("₹ ${_customerData['balance_amount'] ?? ''}",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: primaryWhite,
                )))
          ],
        ),
      ),
    );
  }
}
