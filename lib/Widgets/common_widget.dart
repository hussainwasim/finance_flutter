import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/Colors.dart';
import '../Screens/customer_detail.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 262,
      width: 357,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  child: Image.network(
                    'https://cdn.dribbble.com/users/1176657/screenshots/15468294/media/34af996ddff444391edab94abcf3c7f3.png?compress=1&resize=300x300',
                    // height: 51,
                    // width: 51,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
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
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text(
                          "South street,pudukottai road, Sankarapuram Taluk,\n Gingee",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: primaryWhite,
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                  ],
                ),
                Row(
                  children: [
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              ))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 349,
      decoration: BoxDecoration(
        color: Color(0xFFEAEBF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: secondaryColor,
          child: Text("hii"),
        ),
        title: Text(
          "Vignesh S / 68541 ",
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            color: Color(0xFF424242),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )),
        ),
        subtitle: Row(
          children: [
            Text(
              "Today Due ",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                color: Color(0xFF424242),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
            ),
            Text(
              " 1420000 ",
              style: TextStyle(
                color: Color(0xFFFF7E7E),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerDetails()),
              );
            },
            icon: Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
