import 'dart:convert';

import 'package:fin/models/addCustomerModel.dart';
import 'package:fin/res/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'customer_detail.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  //bool isUserLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersFuture = getUsers();
    setState(() {
      //  isUserLoading = true;
    });
  }

  Future<CustomerModel> usersFuture = getUsers();

  static Future<CustomerModel> getUsers() async {
    var url = "http://127.0.0.1:8000/api/customers/";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $loginResponse'
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
        body:
            // !isUserLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            FutureBuilder<CustomerModel>(
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
                              'assets/images/no_employee.jpeg',
                              height: 180,
                              width: 180,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'No Employee Found!',
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
                                width: MediaQuery.of(context).size.width * 0.8,
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
                              height: MediaQuery.of(context).size.height * 0.15,
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
              color: Colors.grey.withOpacity(0.5),
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
                '${users.data![index].name}',
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
                    " ${users.data![index].loanAmount}",
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
      });
}

class CustomerModel {
  String? message;
  bool? status;
  int? code;
  List<Data>? data;

  CustomerModel({this.message, this.status, this.code, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? cId;
  String? customerId;
  String? name;
  int? contactNo;
  String? address;
  int? loanAmount;
  int? balanceAmount;
  int? dailyDueAmount;
  String? loanDuration;
  String? startingDate;
  int? companyId;
  Null? createdBy;
  Null? updatedBy;
  String? active;
  String? deleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.cId,
      this.customerId,
      this.name,
      this.contactNo,
      this.address,
      this.loanAmount,
      this.balanceAmount,
      this.dailyDueAmount,
      this.loanDuration,
      this.startingDate,
      this.companyId,
      this.createdBy,
      this.updatedBy,
      this.active,
      this.deleted,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    customerId = json['customer_id'];
    name = json['name'];
    contactNo = json['contact_no'];
    address = json['address'];
    loanAmount = json['loan_amount'];
    balanceAmount = json['balance_amount'];
    dailyDueAmount = json['daily_due_amount'];
    loanDuration = json['loan_duration'];
    startingDate = json['starting_date'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    active = json['active'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_id'] = this.cId;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['loan_amount'] = this.loanAmount;
    data['balance_amount'] = this.balanceAmount;
    data['daily_due_amount'] = this.dailyDueAmount;
    data['loan_duration'] = this.loanDuration;
    data['starting_date'] = this.startingDate;
    data['company_id'] = this.companyId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
