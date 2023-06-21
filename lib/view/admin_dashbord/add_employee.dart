import 'package:fin/res/style/colors.dart';
import 'package:fin/view/admin_dashbord/employee_list.dart';
import 'package:fin/view/view_model/add_employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/validator/my_validators.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController mobileNo = TextEditingController();

  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

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
        email.text,
        mobileNo.text,
        address.text,
        password.text,
      );
    }
    setState(() {
      loader = false;
    });
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

                          !loader
                              ? ElevatedButton(
                                  onPressed: (() {
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
                                      ))))
                              : Center(
                                  child: CircularProgressIndicator(),
                                )
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
  // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// class AddEmployeeModel {
//   // static saveEmployee(
//   //   name,
//   //   email,
//   //   mobileNo,
//   //   address,
//   //   password,
//   // ) async {
//   //   const storage = FlutterSecureStorage();
//   //   var loginResponse = await storage.read(key: 'LOGIN_RESS');
//   //   // Map? desiredMap;
//   //   var headers = {
//   //     'Content-type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer $loginResponse'
//   //   };
//   //   var request = http.MultipartRequest(
//   //       'POST', Uri.parse('https://product.artsify.in/public/api/employees'));
//   //   request.fields.addAll({
//   //     'employee_name': 'rarrxxja',
//   //     'email': 'rajdrra@gmail.com',
//   //     'mobile_no': '987456312',
//   //     'address': 'dubai xmain road',
//   //     'password': '1234567x8',
//   //   });
//   //   // if (empProfileFile != null) {
//   //   //   request.files.add(
//   //   //       await http.MultipartFile.fromPath('profile_url', empProfileFile));
//   //   // }
//   //   request.headers.addAll(headers);
//   //   print("request:${request.fields}");
//   //   http.StreamedResponse response = await request.send();
//   //   print("response:${response.statusCode}");
//   //   if (response.statusCode == 200) {
//   //     print(await response.stream.bytesToString());
//   //   } else {
//   //     print(response.reasonPhrase);
//   //     print(response);
//   //   }
//   // }
// }
}
