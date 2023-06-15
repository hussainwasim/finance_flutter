import 'package:fin/res/style/colors.dart';
import 'package:fin/view/admin_dashbord/customer_list.dart';
import 'package:fin/view/admin_dashbord/employee_list.dart';
import 'package:fin/view/view_model/add_employee_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/customer_model.dart';
import '../../utils/validator/my_validators.dart';
import '../../widgets/snackbar.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController dob = TextEditingController();

  //final TextEditingController startingDate = TextEditingController();
  bool loader = false;
//loading
  bool enable = true;
  //save EMployee
  saveEmployee() async {
    setState(() {
      enable = false;
    });
    if (_formKey.currentState!.validate() && !loader) {
      await AddEmployeeModel.saveEmployee(
        name.text,
        mobileNo.text,
        email.text,
        address.text,
        password.text,
      ).whenComplete(() {
        Utils.showTopSnackBar('Employee added successfully',
            title: 'Success', color: Colors.green);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EmployeeList()));
      });
    }
    setState(() {
      loader = true;
    });
  }

  // save customer fun
  // saveCustomer() async {
  //   setState(() {
  //     enable = false;
  //   });
  //   print(name.text);
  //   if (_formkey.currentState!.validate()) {
  //     await CustomerModel.saveCustomer(
  //       name.text,
  //       mobileNo.text,
  //       address.text,
  //       dailyDueAmount.text,
  //       loanAmount.text,
  //       loanDuration.text,
  //     );
  //   }
  // }

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
        title: Text("Add Employee",
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
                    MaterialPageRoute(builder: (context) => EmployeeList()));
              },
              child: Image.asset('assets/images/menu.png'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Container(
              height: 660,
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
                          Text("Employee Name",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: "Enter Employee Name ",
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                                validator: ((value) {
                                  MyValidators.validateEmptyFileds(
                                      value ?? '', 'Employee Name');
                                })),
                          ),
                          // TextField(
                          Text("Employee Email",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: "Enter Employee Email ",
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                                validator: ((value) {
                                  MyValidators.validateEmptyFileds(
                                      value ?? '', 'Employee Email');
                                })),
                          ),

                          Text("Mobile Number",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: mobileNo,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter Mobile Number",
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
                          TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              hintText: "Enter Address",
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
                          Text("Employee Password",
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textPrimary,
                              ))),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Enter Employee Password ",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                MyValidators.validateEmptyFileds(
                                    value ?? '', 'Employee Password');
                              },
                            ),
                          ),
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
                                // saveCustomer();
                                // if (_formkey.currentState!.validate()) {
                                //   print("ok");
                                // } else {
                                //   print('err');
                                // }
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  saveEmployee();
                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(66),
                                  ),
                                  minimumSize: Size(double.infinity, 45)),
                              child: Text('ADD EMPLOYEE',
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
