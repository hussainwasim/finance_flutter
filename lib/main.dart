import 'package:fin/view/login/login.dart';
import 'package:flutter/material.dart';
import 'res/style/colors.dart';
import 'view/admin/admin_dashboard.dart';
import 'view/collection_boy/driver_dashboard.dart';

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

//      home: const DriverDashboard(),

      // home: const AdminDashboard(),
      home: const LogIn(),
    );
  }
}
