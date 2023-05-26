import 'package:fin/view/admin_dashbord/customer_detail.dart';
import 'package:flutter/material.dart';
import 'res/style/colors.dart';
import 'view/admin_dashbord/admin_dashboard.dart';
import 'view/admin_dashbord/customer_list.dart';

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
      // home: const LogIn(),
    );
  }
}
