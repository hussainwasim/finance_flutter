import 'package:flutter/material.dart';
import 'res/style/colors.dart';
import 'view/admin_dashbord/admin_dashboard.dart';
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
      //  home: const AdminDashboard(),
      home: const LogIn(),
    );
  }
}
