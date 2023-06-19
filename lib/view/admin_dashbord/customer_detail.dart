// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/models/loan_model.dart';
import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../res/style/style.dart';
import '../../widgets/customer_info_widget.dart';

class CustomerDetails extends StatefulWidget {
  final int? id;
  const CustomerDetails({super.key, required this.id});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  bool isLoading = false;
  var usermap;
  static const storage = FlutterSecureStorage();

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

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        usermap = body;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(Icons.arrow_back, color: textPrimary)),
          title: Text(
            "Customer Details",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              color: textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
          ),
          //   backgroundColor: primaryWhite,
        ),
        // body: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
        //   child: Column(
        //     children: [
        //       CustomerCard(
        //         id: widget.id,
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Align(
        //         alignment: Alignment(-1, 0),
        //         child: Text(
        //           "Due Transaction",
        //           style: GoogleFonts.inter(
        //               textStyle: TextStyle(
        //                   fontSize: 20,
        //                   color: textPrimary,
        //                   fontWeight: FontWeight.w500)),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Container(
        //           height: SizeConfig.screenHeight! / 2.0,
        //           child: FutureBuilder(
        //               future: usersFuture,
        //               builder: (context, snapshot) {
        //                 if (snapshot.connectionState == ConnectionState.done) {
        //                   if (snapshot.hasData) {
        //                     final Users = snapshot.data!;
        //                     return Users.data != null && Users.data!.isNotEmpty
        //                         ? buildUser(Users)
        //                         : Center(
        //                             child: Text('NO'),
        //                           );
        //                   }
        //                 }
        //                 return Container(
        //                   width: MediaQuery.of(context).size.width,
        //                   height: MediaQuery.of(context).size.height,
        //                   color: Colors.grey.withOpacity(0.5),
        //                   child: const Center(child: CircularProgressIndicator()),
        //                 );
        //               })
        //           // child: buildUser(los),
        //           )
        //     ],
        //   ),
        // ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : buildUsers(usermap));
  }

  Widget buildUsers(usermap) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 69,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFEAEBF4),
                borderRadius: BorderRadius.circular(11),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: secondaryColor,
                  child: usermap['data']['name'] != null
                      ? Text(
                          "${usermap['data']['name'].toString()}",
                          style: TextStyle(
                              color: Color(0xFFEAEBF4),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(''),
                ),
                title: Text("${usermap['data']['name'].toString()}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF1A2131),
                    ))),
                subtitle: Text("${usermap['data']['name'].toString()}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textSecondary,
                    ))),
                trailing: Text("${usermap['data']['name'].toString()}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF019910),
                    ))),
              ),
            ),
          ],
        ),
      );
}

class User {
  final String date;
  final String day;
  final String time;
  final String dueAmount;
  const User({
    required this.date,
    required this.day,
    required this.time,
    required this.dueAmount,
  });
  static User fromJson(json) => User(
      date: json['date'],
      day: json['day'],
      time: json['time'],
      dueAmount: json['due_amount']);
}
