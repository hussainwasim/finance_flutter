import 'package:fin/Api_Models/BaseClients.dart';
import 'package:fin/Api_Models/CustomerModel.dart';
import 'package:fin/Components/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController loanAmount = TextEditingController();

  final TextEditingController dailyDueAmount = TextEditingController();
  final TextEditingController loanDuration = TextEditingController();
  final TextEditingController startingDate = TextEditingController();

//loading
  bool enable = true;

  //save customer fun
  saveCustomer() async {
    setState(() {
      enable = false;
    });
    print(name);
    if (_formkey.currentState!.validate()) {
      await CustomerModel.saveCustomer(
        name,
        contactNo,
        address,
        dailyDueAmount,
        loanAmount,
        loanDuration,
        startingDate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(
            Icons.arrow_back,
            color: textPrimary,
          ),
        ),
        title: Text("Add Customer",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textPrimary,
            ))),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {}, child: Image.asset('assets/images/menu.png'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60,
              height: 60,
              child: Center(
                  child: GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/image 4.png'))),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
            ),
            Text("Profile Picture",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: textPrimary,
                ))),
            Form(
              key: _formkey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Customer Name",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textPrimary,
                          ))),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Enter Customer Name ",
                          label: Text("Customer Name"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ),
                      // TextField(
                      //   controller: email,
                      //   keyboardType: TextInputType.url,
                      //   decoration: InputDecoration(
                      //     hintText: "Enter Customer Email ",
                      //     label: Text("Email"),
                      //     border: OutlineInputBorder(),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: textPrimary,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text("Mobile Number",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textPrimary,
                          ))),
                      TextField(
                        controller: contactNo,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          label: Text("Mobile Number"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ),
                      Text("Address",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textPrimary,
                          ))),
                      TextField(
                        controller: address,
                        decoration: InputDecoration(
                          hintText: "Enter Address",
                          label: Text("Address"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textPrimary,
                            ),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      Text("Loan Amount",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textPrimary,
                          ))),
                      TextField(
                        controller: loanAmount,
                        decoration: InputDecoration(
                          hintText: "Enter Loan Amount ",
                          label: Text("Loan Amount"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textPrimary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Text("Daily Due Amount",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textPrimary,
                          ))),
                      TextField(
                        controller: dailyDueAmount,
                        decoration: InputDecoration(
                          hintText: "Enter Daily Loan Amount ",
                          label: Text("Daily Loan Amount"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textPrimary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      // TextField(
                      //   controller: loanDuration,
                      //   decoration: InputDecoration(
                      //     hintText: "Enter Loan Duration",
                      //     label: Text('Loan Duration'),
                      //     border: OutlineInputBorder(),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: textPrimary,
                      //       ),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.number,
                      // ),
                      // TextField(
                      //   controller: loanDuration,
                      //   decoration: InputDecoration(
                      //     hintText: "Enter Loan Starting Date",
                      //     label: Text('Loan Starting Date'),
                      //     border: OutlineInputBorder(),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: textPrimary,
                      //       ),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.number,
                      // ),
                      ElevatedButton(
                          onPressed: (() {
                            saveCustomer();
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(66),
                              ),
                              minimumSize: Size(double.infinity, 60)),
                          child: Text('ADD CUSTOMER',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 23,
                                color: primaryWhite,
                              )))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
