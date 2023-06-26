import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/admin_dashbord/customer_detail.dart';
import 'package:fin/view/admin_dashbord/customer_list.dart';
import 'package:fin/view/view_model/apiMethod.dart';
import 'package:fin/widgets/customer_info_widget.dart';
import 'package:fin/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class addFund extends StatefulWidget {
  const addFund({super.key});

  @override
  State<addFund> createState() => _addFundState();
}

class _addFundState extends State<addFund> {
  int? id = 3;
  static const storage = FlutterSecureStorage();
  bool isLoader = false;
  final _formKey = GlobalKey<FormState>();
  final addFund = TextEditingController();
  _addFund() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    setState(() {
      isLoader = true;
    });
    var url = 'https://product.artsify.in/public/api/loan/3';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    Map<String, String> body = {
      "collection_amount": addFund.text,
    };

    var response = await ApiMethods.post(url, body);
    print(response.body);
    if (response.statusCode == 200) {
      // Utils.showTopSnackSuccessBar("Add Due Amount Successfully");
      return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetails(
              id: id,
            ),
          ));
    } else if (response.statusCode == 422) {
      print(response.toString());
      //  Utils.showTopSnackBar("Something Wrong Try Again...");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerList(),
                ));
          }),
          icon: Icon(
            Icons.arrow_back,
            color: textPrimary,
          ),
        ),
        title: Text("ADD FUND",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textPrimary,
            ))),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: khorizontalPadding,
        ),
        child: Column(
          children: [
            CustomerCard(),
            SizedBox(
              height: 30,
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Due Amount :",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: textPrimary,
                      ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          controller: addFund,
                          decoration: InputDecoration(
                            hintText: 'Enter Due Amount',
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              //fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFB1B1B1),
                            )),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB1B1B1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB1B1B1),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: (() {
                        if (_formKey.currentState!.validate() && !isLoader) {
                          _addFund();
                        }
                      }),
                      child: Text(
                        'ADD FUND',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: primaryWhite,
                        )),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
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
      ),
    );
  }
}
