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
  static const storage = FlutterSecureStorage();
  Map customerMap = {};
  bool isLoading = false;
  // Future getUsers() async {
  //   var loginResponse = await storage.read(key: 'LOGIN_RESS');
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var url = baseUrl + '/loan/fetch-complete/1'; // widget.id.toString();
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $loginResponse'
  //   };
  //   final response = await http.get(Uri.parse(url), headers: requestHeaders);

  //   final data = json.decode(response.body);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       //customerMap = body;
  //       customerMap = data['data'];
  //       isLoading = false;
  //     });
  //   } else {
  //     print(response.body);
  //   }
  // }

  Future usersFuture = getUsers();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   usersFuture = getUsers();
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  static Future<LoanModel> getUsers() async {
    var url = baseUrl + '/loan/fetch-complete/1'; // widget.id.toString();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmE3YzQ4MDM4MWM5MTZjNDczODIxYzhjZDQyMDVmNjBiY2Q2NmI4ZmM2MDRjMjg4M2Y1NzM0OGYzMzkzNmY0NWZkNGY4Y2I3NWZiZGY1NDciLCJpYXQiOjE2ODcwODA0ODcuMzUzNTkxOTE4OTQ1MzEyNSwibmJmIjoxNjg3MDgwNDg3LjM1MzU5NDA2NDcxMjUyNDQxNDA2MjUsImV4cCI6MTcxODcwMjg4Ny4zNDkzOTkwODk4MTMyMzI0MjE4NzUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.Cnw-ColvvAtJsv2LHdxKIfWA1_cj-R2h0cDZFtwglXwT0nNrUdV_8Y0hBVv93spFy4x2LX_z2JC9BPD45-Wky2LZuItrmHik_sX52nOtKevFV-RB40swlLzcBd9uAtMSGRK3pxfeWScZFTei7pkb5A2_AjtJTsGCP2adVwAMjyL4RELPLq-7Bbi4SczNopIh4E_2qLpGBwCkFeDfVJKkkpMwm4bs4QfedBkTWNVvq-XqSMjubb5AbDbPOwOMFBxbu5s-v_dpMzntxdBRif8RC9zFti4AelAO8awS8KDg44fOReK0pQkiwHE8Eblo7_7MxlJG28Le11rXRKDCRr7jbj-6uT9xhyIMl2R1u--ygvpeBBGnRyjhrr4Zu2MwAVn7GfhOlKKC9Y5TBNWJiA3G6EoanKKhl4Od3yJ1IuCZ03ucyj-3ymSQ_wguaczK75jJdz3-ZMFn-KrB0Fy7r380-GTPbskDecVqrjSjhwySV3TyekquNpfTAJbT3m7w7kOvqaSFUwIOUC7VkWhMloRsmNTZkJoVRp8l54SuavBDn4Ktpn-0aDX-Ox5I0OcUW7iu2M6uC_WkYURGWYWZWuC93wr2yACTcsR3kD32SE-nPi_6j0JDaB8eeGQgj8Bg5vekgBf8d-mX1dyNPSfN99sF48WISpuCAjqXb_QHnfDgEx4'
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    final body = json.decode(response.body);
    print(body['data']);
    return LoanModel.fromJson(jsonDecode(response.body));
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
        child: Column(
          children: [
            CustomerCard(
              id: widget.id,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
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
            SizedBox(
              height: 5,
            ),
            Container(
                height: SizeConfig.screenHeight! / 2.0,
                child: FutureBuilder(
                    future: usersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          final Users = snapshot.data!;
                          return Users.data != null && Users.data!.isNotEmpty
                              ? buildUser(Users)
                              : Center(
                                  child: Text('NO'),
                                );
                        }
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.grey.withOpacity(0.5),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    })
                // child: buildUser(los),
                )
          ],
        ),
      ),
    );
  }

  Widget buildUser(LoanModel Users) => ListView.separated(
        itemCount: Users.data!.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 9,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 69,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: Color(0xFFEAEBF4),
              borderRadius: BorderRadius.circular(11),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: secondaryColor,
                child: Users.data![index].lId != null
                    ? Text(
                        "${Users.data![index].lId}",
                        style: TextStyle(
                            color: Color(0xFFEAEBF4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(''),
              ),
              title: Text('Last Due :  ${Users.data![index].collectionDate}',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1A2131),
                  ))),
              subtitle: Text('Time : ${Users.data![index].collectionDate}',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textSecondary,
                  ))),
              trailing: Text("₹ ${Users.data![index].dailyDueAmount}",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF019910),
                  ))),
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
