import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/admin_dashbord/customer_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/customer_model.dart';
import '../../utils/validator/my_validators.dart';

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
  //final TextEditingController startingDate = TextEditingController();

//loading
  bool enable = true;

  // save customer fun
  saveCustomer() async {
    setState(() {
      enable = false;
    });
    print(name.text);
    if (_formkey.currentState!.validate()) {
      await CustomerModel.saveCustomer(
        context,
        name.text,
        contactNo.text,
        address.text,
        dailyDueAmount.text,
        loanAmount.text,
        loanDuration.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        title: Text("ADD CUSTOMER",
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textPrimary,
            ))),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerList()));
              },
              child: Image.asset('assets/images/menu.png'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Container(
              height: SizeConfig.screenHeight! / 1.15,
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
                  Expanded(
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
                          SizedBox(
                            height: 36,
                            child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: "Enter Customer Name ",
                                  hintStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[400],
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                                validator: ((value) {
                                  MyValidators.validateEmptyFileds(
                                      value ?? '', 'Customer Name');
                                })),
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
                          SizedBox(
                            height: 36,
                            child: TextFormField(
                              controller: contactNo,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter Customer Mobile Number ",
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                MyValidators.ValidateContact(
                                    value ?? '', 'Mobile Number');
                              },
                            ),
                          ),
                          Text("Address",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 84,
                            child: TextFormField(
                              controller: address,
                              decoration: InputDecoration(
                                hintText: "Enter Customer Address ",
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                MyValidators.validateEmptyFileds(
                                    value ?? '', 'Address');
                              },
                              maxLines: 3,
                            ),
                          ),
                          Text("Loan Amount",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 36,
                            child: TextFormField(
                              controller: loanAmount,
                              decoration: InputDecoration(
                                hintText: "Enter Loan Amount ",
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                MyValidators.validateEmptyFileds(
                                    value ?? '', 'Loan Amount');
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Text("Daily Due Amount",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 36,
                            child: TextFormField(
                              controller: dailyDueAmount,
                              decoration: InputDecoration(
                                hintText: "Enter Daily Loan Amount",
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                MyValidators.validateEmptyFileds(
                                    value ?? '', 'Daily Due Amount');
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          // SizedBox(
                          //   height: 50,
                          //   child: TextField(
                          //     controller: loanDuration,
                          //     decoration: InputDecoration(
                          //       hintText: "Enter Daily Loan Duration ",
                          //       border: OutlineInputBorder(),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: textPrimary,
                          //         ),
                          //       ),
                          //     ),
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // // TextField(
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
                                if (_formkey.currentState!.validate()) {
                                  print("ok");
                                } else {
                                  print('err');
                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(66),
                                  ),
                                  minimumSize: Size(double.infinity, 40)),
                              child: Text('ADD CUSTOMER',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: primaryWhite,
                                  )))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
