import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/view/admin_dashbord/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../res/style/colors.dart';
import '../driver_dashbord/driver_dashboard.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  Future<EmployeeListModel> usersFuture = getUsers();
  static const storage = FlutterSecureStorage();
  var role = storage.read(key: 'User_Role');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersFuture = getUsers();
  }

  static Future<EmployeeListModel> getUsers() async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    var url = 'http://product.artsify.in/public/api/employees/';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    var body = jsonDecode(response.body);
    return EmployeeListModel.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (() {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DriverDashboard()),
              (route) => false,
            );
          }),
          icon: Icon(
            Icons.arrow_back,
            color: textPrimary,
          ),
        ),
        title: Text(
          "Employee List",
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            color: textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
        ),
      ),
      body: FutureBuilder<EmployeeListModel>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return users.data != null && users.data!.isNotEmpty
                  ? ListView.builder(
                      itemCount: users.data?.length,
                      itemBuilder: (context, index) {
                        var User = users.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: SizedBox(
                            height: 72,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(0.5),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Color(0xFFEAEBF4),
                                child: ListTile(
                                  title: Text(
                                    '${users.data![index].employeeName}',
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                    ),
                                  ),
                                  trailing: Image.asset(
                                    'assets/images/arrow.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : Column(
                      children: [
                        Image.asset(
                          'assets/images/no_employee.jpeg',
                          height: 180,
                          width: 180,
                        ),
                      ],
                    );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.withOpacity(0.5),
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      //FutureBuilder(future: EmployeeFuture, builder: builder),
    );
  }
}

class EmployeeListModel {
  String? message;
  bool? status;
  int? code;
  List<Data>? data;

  EmployeeListModel({this.message, this.status, this.code, this.data});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? employeeName;
  String? employeeNumber;
  String? email;
  String? mobileNo;
  String? profileUrl;
  String? employeeStatus;

  Data(
      {this.id,
      this.employeeName,
      this.employeeNumber,
      this.email,
      this.mobileNo,
      this.profileUrl,
      this.employeeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    employeeNumber = json['employee_number'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    profileUrl = json['profile_url'];
    employeeStatus = json['employee_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_name'] = this.employeeName;
    data['employee_number'] = this.employeeNumber;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['profile_url'] = this.profileUrl;
    data['employee_status'] = this.employeeStatus;
    return data;
  }
}
