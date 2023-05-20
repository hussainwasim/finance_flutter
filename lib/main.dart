import 'package:fin/Components/Colors.dart';
import 'package:fin/Screens/add_customer.dart';
import 'package:fin/Screens/add_fund.dart';
import 'package:fin/Screens/admin_dashboard.dart';
import 'package:fin/Screens/collection_list.dart';
import 'package:fin/Screens/customer_detail.dart';
import 'package:fin/Screens/customer_list.dart';
import 'package:fin/Screens/driver_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primaryWhite,
        ),
        scaffoldBackgroundColor: primaryWhite,
      ),
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: const CustomerDetails(),
      //   home: const addFund(),
      home: const CustomerList(),
      //home: const CollectionList(),
      // home: const DriverDashboard(),
      //home: const AddCustomer(),
      //home: const AdminDashboard(),
    );
  }
}
