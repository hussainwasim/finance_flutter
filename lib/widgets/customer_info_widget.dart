import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/driver_dashbord/add_fund.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fin/res/style/colors.dart';

import '../view/admin_dashbord/customer_detail.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
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
                      "Vignesh.S/10001",
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
                Text("\t +91 \t9874563210",
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
                Text("\t Vicky007@gmail.com",
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
                Text("₹ 15,25,0000",
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
            Text("₹ 15,25,0000",
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
