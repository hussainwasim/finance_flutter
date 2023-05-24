import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/style/colors.dart';
import '../view/driver_dashbord/add_fund.dart';
import '../view/admin_dashbord/customer_detail.dart';

class CollectionCompleted extends StatelessWidget {
  const CollectionCompleted({super.key});

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
                color: Color(0xFF019910),
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

class CollectionPending extends StatelessWidget {
  const CollectionPending({super.key});

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
                MaterialPageRoute(builder: (context) => const addFund()),
              );
            },
            icon: Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
