import 'dart:convert';

import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/driver_dashbord/add_fund.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  Map _customerData = {};
  Future getUsers() async {
    // var loginResponse = await storage.read(key: 'LOGIN_RESS');
    setState(() {
      isLoading = true;
    });
    var url =
        'http://product.artsify.in/public/api/customers/1'; //widget.id.toString();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmE3YzQ4MDM4MWM5MTZjNDczODIxYzhjZDQyMDVmNjBiY2Q2NmI4ZmM2MDRjMjg4M2Y1NzM0OGYzMzkzNmY0NWZkNGY4Y2I3NWZiZGY1NDciLCJpYXQiOjE2ODcwODA0ODcuMzUzNTkxOTE4OTQ1MzEyNSwibmJmIjoxNjg3MDgwNDg3LjM1MzU5NDA2NDcxMjUyNDQxNDA2MjUsImV4cCI6MTcxODcwMjg4Ny4zNDkzOTkwODk4MTMyMzI0MjE4NzUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.Cnw-ColvvAtJsv2LHdxKIfWA1_cj-R2h0cDZFtwglXwT0nNrUdV_8Y0hBVv93spFy4x2LX_z2JC9BPD45-Wky2LZuItrmHik_sX52nOtKevFV-RB40swlLzcBd9uAtMSGRK3pxfeWScZFTei7pkb5A2_AjtJTsGCP2adVwAMjyL4RELPLq-7Bbi4SczNopIh4E_2qLpGBwCkFeDfVJKkkpMwm4bs4QfedBkTWNVvq-XqSMjubb5AbDbPOwOMFBxbu5s-v_dpMzntxdBRif8RC9zFti4AelAO8awS8KDg44fOReK0pQkiwHE8Eblo7_7MxlJG28Le11rXRKDCRr7jbj-6uT9xhyIMl2R1u--ygvpeBBGnRyjhrr4Zu2MwAVn7GfhOlKKC9Y5TBNWJiA3G6EoanKKhl4Od3yJ1IuCZ03ucyj-3ymSQ_wguaczK75jJdz3-ZMFn-KrB0Fy7r380-GTPbskDecVqrjSjhwySV3TyekquNpfTAJbT3m7w7kOvqaSFUwIOUC7VkWhMloRsmNTZkJoVRp8l54SuavBDn4Ktpn-0aDX-Ox5I0OcUW7iu2M6uC_WkYURGWYWZWuC93wr2yACTcsR3kD32SE-nPi_6j0JDaB8eeGQgj8Bg5vekgBf8d-mX1dyNPSfN99sF48WISpuCAjqXb_QHnfDgEx4'
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
