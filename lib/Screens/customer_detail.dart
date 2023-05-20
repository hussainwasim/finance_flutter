import 'package:fin/Components/Colors.dart';
import 'package:fin/Widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  List<User> users = getDuetransaction();
  static List<User> getDuetransaction() {
    const data = [
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
      {
        "date": " 12/12/2023",
        "day": " Sunday",
        "time": "10:05 am ",
        "due_amount": "500 ",
      },
    ];
    return data.map<User>(User.fromJson).toList();
  }

  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          CustomerCard(),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 360,
            child: buildUser(users),
          )
        ],
      ),
    );
  }

  Widget buildUser(List<User> users) => ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 9,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              height: 69,
              width: 349,
              decoration: BoxDecoration(
                color: Color(0xFFEAEBF4),
                borderRadius: BorderRadius.circular(11),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: secondaryColor,
                  child: Text(user.date[index][0]),
                ),
                title: Text("Last Due : " + user.date,
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF1A2131),
                    ))),
                subtitle: Text("Time : " + user.time,
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textSecondary,
                    ))),
                trailing: Text("₹" + user.due_amount,
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF019910),
                    ))),
              ),
            ),
          );
        },
      );
}

class User {
  final String date;
  final String day;
  final String time;
  final String due_amount;
  const User({
    required this.date,
    required this.day,
    required this.time,
    required this.due_amount,
  });
  static User fromJson(json) => User(
      date: json['date'],
      day: json['day'],
      time: json['time'],
      due_amount: json['due_amount']);
}
