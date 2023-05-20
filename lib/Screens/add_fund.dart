import 'package:fin/Components/Colors.dart';
import 'package:fin/Widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class addFund extends StatefulWidget {
  const addFund({super.key});

  @override
  State<addFund> createState() => _addFundState();
}

class _addFundState extends State<addFund> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(
            Icons.arrow_back,
            color: textPrimary,
          ),
        ),
        title: Text("Add Fund",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textPrimary,
            ))),
      ),
      body: Column(
        children: [
          CustomerCard(),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'ADD DUE ',
              style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              //style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                    text: 'FUND',
                    style: TextStyle(
                      color: Color(0xFF85C893),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text("Due Amount :",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: textPrimary,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Due Amount',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textPrimary,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: Text(
                      'ADD FUND',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: primaryWhite,
                      )),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(333, 60),
                        primary: primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(66)),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
