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

import '../../widgets/customer_info_widget.dart';

class CustomerDetails extends StatefulWidget {
  final int? id;
  const CustomerDetails({super.key, required this.id});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  static const storage = FlutterSecureStorage();
  var customerMap = {};
  bool isLoading = false;
  Future getUsers() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    setState(() {
      isLoading = true;
    });
    var url = baseUrl + '/loan/fetch-complete/1'; // widget.id.toString();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        customerMap = body;

        isLoading = false;
      });
    } else {
      print(response.body);
    }
  }

  //Future usersFuture = getUsers();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   usersFuture = getUsers();
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  // static Future<loan> getUsers() async {
  //   var url = baseUrl + '/loan/fetch-complete/1'; // widget.id.toString();
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     //  'Authorization': 'Bearer $loginResponse'
  //   };

  //   final response = await http.get(Uri.parse(url), headers: requestHeaders);
  //   final body = json.decode(response.body);
  //   print(body['data']);
  //   return loan.fromJson(jsonDecode(response.body));
  // }

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
      body: Column(
        children: [
          CustomerCard(),

          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Due Transaction",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: textPrimary,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 360,
            // child: FutureBuilder(
            //     future: usersFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         if (snapshot.hasData) {
            //           final Users = snapshot.data!;
            //           return Users.data != null && Users.data!.isNotEmpty
            //               ? buildUser(Users)
            //               : Center(
            //                   child: Text('NO'),
            //                 );
            //         }
            //       }
            //       return Container(
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height,
            //         color: Colors.grey.withOpacity(0.5),
            //         child: const Center(child: CircularProgressIndicator()),
            //       );
            //     })
            child: buildUser(customerMap),
          )
        ],
      ),
    );
  }

  Widget buildUser(customerMap) => ListView.separated(
        itemCount: customerMap.lenght,
        separatorBuilder: (context, index) => SizedBox(
          height: 9,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              height: 69,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFEAEBF4),
                borderRadius: BorderRadius.circular(11),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: secondaryColor,
                  child: customerMap['data']['l_id'] != null
                      ? Text(
                          "${customerMap['data']['name']}",
                          style: TextStyle(
                              // color: oxfordBlue,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(''),
                ),
                // title: Text(
                //     "Last Due : " + ' ${Users.data![index].collectionDate}',
                //     style: GoogleFonts.inter(
                //         textStyle: const TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: 16,
                //       color: Color(0xFF1A2131),
                //     ))),
                // subtitle:
                //     Text("Time : " + ' ${Users.data![index].collectionDate}',
                //         style: GoogleFonts.inter(
                //             textStyle: const TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400,
                //           color: textSecondary,
                //         ))),
                trailing: Text("₹" + " ${customerMap['data']['loan_amount']}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF019910),
                    ))),
              ),
            ),
          );
        },
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
