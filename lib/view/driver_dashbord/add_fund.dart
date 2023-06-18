import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/res/style/colors.dart';
import 'package:fin/widgets/customer_info_widget.dart';
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
  static const storage = FlutterSecureStorage();
  bool isLoader = false;
  final _formKey = GlobalKey<FormState>();
  final addFund = TextEditingController();
  _addFund() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    setState(() {
      isLoader = true;
    });
    var url = Uri.parse('https://product.artsify.in/public/api/loan/1/');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYWIxZDI2NDRlZTA3MjQ1ZTc0OWZjMGQwODY0NjU5MjUzODFmZDViOGE4NjVjM2M3ZjFkOTc2MGEyODM1ZTY3NWI0NTNmNjE4NjMwNWE3OGYiLCJpYXQiOjE2ODY5OTIwNzMuOTYyMDczMDg3NjkyMjYwNzQyMTg3NSwibmJmIjoxNjg2OTkyMDczLjk2MjA3NDk5NTA0MDg5MzU1NDY4NzUsImV4cCI6MTcxODYxNDQ3My45NjExMDcwMTU2MDk3NDEyMTA5Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.xDE8hUgW3BaAtfuj6omFEbT_Ze84LpvHMDTDDoisft1MtphvmXSyNhv8TyiFNMcFQuHWOfn6mJVRPwiExRmA--zGsHUXBt2opYrbGohE2yIL8qZL6zI6H5x8S8Nq8WC_T4hudKgsNzASVGGAQHhYbG7jMXOYPlxOJjGTlD-kY87153oiNcibrK36wmD-7YFgjnQBRBwYsdv_tvyKIjgdu2TEgwBS2JU6VngsZKz9va-Vi2kTrnGW5nw8sA_OgndCMjzvkU95AI9XSnMG-da56etMpBTtwlA9F_g7xzVJCh48ANTFkxybKzOyjhXJzlhgllef-4Heb9K7pSbNPCOJJPRvEou3bAsns58PrPC0fsroBDuLrtxw5_heVdsVoWCM0ZOQPIo7a1zR4_72oE73guhBM67kNiJxCcLccqbrbZ-xyZf3JB7CdRswpJTcVWvz9rcagvP_T1dQ8UugOjj4rN0sWqTLe4PKytB1lDji7Lni37Z4BqVgvvlo2b62UDzyLLyOSIau6jDXXVwsC2e4XErSqfygMLzIfY9Hw9yD4CrIcE07icbTiJCzYkncMFBffnUFnHB5ppZdHWiw3xKjAvYiTtjdflGqOhqjFcF67wpnUffxtNOVKvxUxSSKJWupsBhEdxTxNSzxUi4DjVvElciV0ui0TE2nDkicK8-zbDI'
    };
    Map<String, dynamic> body = {
      "daily_due_amount": addFund.text,
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == 200) {
      print("success");
    } else if (response.statusCode == 422) {
      print('no');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        controller: addFund,
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
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ElevatedButton(
                      onPressed: (() {
                        if (_formKey.currentState!.validate() && !isLoader) {
                          _addFund().whenComplete(() {});
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
                          minimumSize: Size(333, 45),
                          primary: primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(66)),
                          )),
                    ),
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
