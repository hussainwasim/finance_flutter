import 'package:fin/view/admin_dashbord/add_customer.dart';
import 'package:fin/view/admin_dashbord/customer_detail.dart';
import 'package:fin/view/admin_dashbord/employee_list.dart';
import 'package:fin/view/driver_dashbord/add_fund.dart';
import 'package:flutter/material.dart';
import 'res/style/colors.dart';
import 'view/admin_dashbord/admin_dashboard.dart';
import 'view/admin_dashbord/customer_list.dart';
import 'view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryWhite,
        ),
        scaffoldBackgroundColor: primaryWhite,
      ),
      debugShowCheckedModeBanner: false,
      home: CustomerList(),
      //  home: AddCustomer(),
      //home: EmployeeList(),
      //home: const LogIn(),
      //home: const addFund(),
    );
  }
}
