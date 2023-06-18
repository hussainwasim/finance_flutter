import 'dart:convert';

import 'package:fin/models/addCustomerModel.dart';
import 'package:fin/res/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../models/customer_model.dart';
import 'customer_detail.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isUserLoading = false;
  static const storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersFuture = getUsers();
    setState(() {
      isUserLoading = true;
    });
  }

  Future<CustomerModel> usersFuture = getUsers();

  static Future<CustomerModel> getUsers() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    var url = "http://product.artsify.in/public/api/customers/";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmE3YzQ4MDM4MWM5MTZjNDczODIxYzhjZDQyMDVmNjBiY2Q2NmI4ZmM2MDRjMjg4M2Y1NzM0OGYzMzkzNmY0NWZkNGY4Y2I3NWZiZGY1NDciLCJpYXQiOjE2ODcwODA0ODcuMzUzNTkxOTE4OTQ1MzEyNSwibmJmIjoxNjg3MDgwNDg3LjM1MzU5NDA2NDcxMjUyNDQxNDA2MjUsImV4cCI6MTcxODcwMjg4Ny4zNDkzOTkwODk4MTMyMzI0MjE4NzUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.Cnw-ColvvAtJsv2LHdxKIfWA1_cj-R2h0cDZFtwglXwT0nNrUdV_8Y0hBVv93spFy4x2LX_z2JC9BPD45-Wky2LZuItrmHik_sX52nOtKevFV-RB40swlLzcBd9uAtMSGRK3pxfeWScZFTei7pkb5A2_AjtJTsGCP2adVwAMjyL4RELPLq-7Bbi4SczNopIh4E_2qLpGBwCkFeDfVJKkkpMwm4bs4QfedBkTWNVvq-XqSMjubb5AbDbPOwOMFBxbu5s-v_dpMzntxdBRif8RC9zFti4AelAO8awS8KDg44fOReK0pQkiwHE8Eblo7_7MxlJG28Le11rXRKDCRr7jbj-6uT9xhyIMl2R1u--ygvpeBBGnRyjhrr4Zu2MwAVn7GfhOlKKC9Y5TBNWJiA3G6EoanKKhl4Od3yJ1IuCZ03ucyj-3ymSQ_wguaczK75jJdz3-ZMFn-KrB0Fy7r380-GTPbskDecVqrjSjhwySV3TyekquNpfTAJbT3m7w7kOvqaSFUwIOUC7VkWhMloRsmNTZkJoVRp8l54SuavBDn4Ktpn-0aDX-Ox5I0OcUW7iu2M6uC_WkYURGWYWZWuC93wr2yACTcsR3kD32SE-nPi_6j0JDaB8eeGQgj8Bg5vekgBf8d-mX1dyNPSfN99sF48WISpuCAjqXb_QHnfDgEx4'
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    final body = json.decode(response.body);
    // print(body['data']);
    return CustomerModel.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Customer List',
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: textPrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: !isUserLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<CustomerModel>(
                future: usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      return users.data != null && users.data!.isNotEmpty
                          ? buildUsers(users)
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/nodata.png',
                                    height: 180,
                                    width: 180,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                    'Cutomer Not  Found!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff002145)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xff002145),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Employee',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                  ),
                                ],
                              ),
                            );
                    } else {
                      return Center(child: Text('no data'));
                    }
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ));
  }

  Widget buildUsers(CustomerModel users) => ListView.builder(
      itemCount: users.data?.length,
      itemBuilder: (context, index) {
        // print(users.data);
        var User = users.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerDetails(
                          id: User.cId,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEAEBF4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          '${users.data![index].name}',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                        Text(
                          ' - ${users.data![index].customerId}',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Text(
                            "Finance : ",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                          Text(
                            " ${users.data![index].loanAmount} :",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0xFF019910),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            )),
                          ),
                          Text(
                            " ${users.data![index].balanceAmount}",
                            style: TextStyle(
                              color: Color(0xFFFF7E7E),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Image.asset(
                      'assets/images/arrow.png',
                      height: 20,
                    )),
              ),
            ),
          ),
        );
      });
}
