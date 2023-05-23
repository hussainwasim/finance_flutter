import 'package:fin/res/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customer_detail.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isLoading = false;
  //Future<CustomerListModel> futureCustomer = getCustomer();

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   var futureCustomer = getCustomer();
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  // Future<CustomerListModel> getCustomer() async {
  //   var response = await BaseClient().get('/customer');
  //   return response;
  // }

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
      body: Container(
        height: 630,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                child: Container(
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
                          "Finance : ",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                        Text(
                          " 185200 /",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            color: Color(0xFF019910),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
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
                ),
              );
            })),
      ),
    );
  }
}

class CustomerListModel {
  int? id;
  String? customerName;
  String? customerNumber;

  int? loanAmount;
  int? balanceAmount;

  String? profileUrl;

  CustomerListModel(
      {this.id,
      this.customerName,
      this.customerNumber,
      this.loanAmount,
      this.balanceAmount,
      this.profileUrl});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerNumber = json['customer_number'];
    loanAmount = json["loan_amount"];
    balanceAmount = json["balance_amount"];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_number'] = this.customerNumber;
    data['loan_amount'] = this.loanAmount;
    data['balance_amount'] = this.balanceAmount;
    data['profile_url'] = this.profileUrl;
    return data;
  }
}
