import 'dart:convert';

import 'package:fin/res/style/colors.dart';
import 'package:fin/res/style/style.dart';
import 'package:fin/res/style/typography.dart';
import 'package:fin/view/admin_dashbord/add_employee.dart';
import 'package:fin/view/admin_dashbord/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/BaseClients.dart';
import '../../utils/storage_helpers/storage_helpers.dart';
import '../../widgets/snackbar.dart';
import '../admin_dashbord/add_customer.dart';
import 'collection_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  @override
  Map _userData = {};
  static const storage = FlutterSecureStorage();
  // _fetchUserData() async {
  //   var data = jsonDecode(
  //       StorageHelper.instance.getString(StorageHelperString.loginUserData) ??
  //           "");
  //   setState(() {
  //     _userData = data['user'];
  //     // print(_userData['designation']);
  //   });
  // }

  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchUserData();
    _fetchDashboardStats();
  }

  Map _dashboardData = {};
  // Map _dashboardUser = {};
  bool _isLoading = false;

  _fetchDashboardStats() async {
    setState(() {
      _isLoading = true;
    });
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    String url = 'http://product.artsify.in/public/api/dashboard/';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    var response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      Map resBodyMap = jsonDecode(response.body);
      setState(() {
        _dashboardData = resBodyMap['data'];
        //_dashboardUser = resBodyMap['user'];
        _isLoading = false;
        print(_dashboardData);
      });
    } else {
      print(response.statusCode);
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
  }

  //determine current location
  Position? _currentPosition;
  String? _currentAddress;

  //handle location permission
  Future<bool> _checkLocationPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      Fluttertoast.showToast(
          msg: 'Please enable location services',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: 'Location permissions are denied',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return await _getCurrentLocation();
    }
    return false;
  }

  //fetch current lat long
  Future<bool> _getCurrentLocation() async {
    Navigator.pop(context);
    _dialogLoader();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _currentPosition = position;
    });
    return await _getAddressFromLatLng();
  }

  //fetch current address
  Future<bool> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
      });
      print(_currentAddress);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  _addPunchInPunchOutApi(bool isPunchIn) async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    var userData = await storage.read(key: 'User_Id');
    String url = '${baseUrl}attendance/punch';
    var body = {
      'latitude': _currentPosition!.latitude,
      'longitude': _currentPosition!.longitude,
      'address': _currentAddress,
      'employee_id': userData,
      "status": isPunchIn ? "PUNCH_IN" : "PUNCH_OUT"
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    var response = await http.post(Uri.parse(url),
        headers: requestHeaders, body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == 200) {
      if (isPunchIn) {
        Navigator.pop(context);
        await StorageHelper.setPunchIn();
        showDialog(
            context: context,
            builder: (context) => _showPunchInSucessFully(true));
      } else {
        Navigator.pop(context);
        await StorageHelper.setPunchOut();
        showDialog(
            context: context,
            builder: (context) => _showPunchInSucessFully(false));
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _dialogLoader() {
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 70,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.network(
              'https://cdn.dribbble.com/users/1176657/screenshots/15468294/media/34af996ddff444391edab94abcf3c7f3.png?compress=1&resize=300x300',
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
        title: Text(
          "Hi! ${_dashboardData['user']}",
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textPrimary,
          )),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCustomer()));
              },
              child: Image.asset('assets/images/image 1.png')),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
        child: Column(
          children: [
            Container(
              height: 93,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Attendence",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primaryWhite,
                          ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Check In",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                              Text(
                                "10.30 am",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Check Out",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                              Text(
                                "7.30 pm",
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: primaryWhite,
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool isPunchIn = await StorageHelper.isPunchIn();
                      bool isPunchOut = await StorageHelper.isPunchOut();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return _showPuchInPunchOutDialog(
                                isPunchIn, isPunchOut);
                          });
                    },
                    child: Container(
                      width: 62,
                      height: 62,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: Image.asset('assets/images/punchin.png')),
                          Text(
                            "Check In",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 7,
                              color: Color(0xFF424242),
                            )),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryWhite),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Total Collection Amount",
                        style: TextStyle(
                            color: Color(0xFFB2B2B4),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                                text: "₹ ${_dashboardData['totalCollection']}",
                                style: TextStyle(color: Color(0xFF000000))),
                            TextSpan(
                                text: ".00/-",
                                style: TextStyle(color: Color(0xFFB1B1B1))),
                            TextSpan(
                              text: "Year",
                              style: TextStyle(
                                  color: Color(0xFFB1B1B1), fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: SizeConfig.screenWidth! / 2.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Target Collection",
                            style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Text("₹ ${_dashboardData['targetCollection']}",
                            style: TextStyle(
                                color: Color(0xFFFF7E7E),
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFE3E9F0),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Container(
                    height: 80,
                    width: SizeConfig.screenWidth! / 2.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Today Collection",
                            style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Text("₹  ${_dashboardData['totalCollection']}",
                            style: TextStyle(
                                color: Color(0xFF6DC576),
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFE3E9F0),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "COLLECTION LIST",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: textPrimary,
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerList()),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Click here",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Color(0xFF424242),
                            )),
                          ),
                          Image.asset('assets/images/image 3.png')
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFDEDFFF),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: lightColor, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFB7B8DC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFB7DDD2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 116,
                  width: 106.16,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDBEA9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Danger",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textPrimary,
                        )),
                      ),
                      Container(
                        height: 41,
                        width: 43.48,
                        child: Center(child: Text("5")),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white54,
                          //  borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPuchInPunchOutDialog(bool isPunchIn, bool isPunchOut) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Do you want to Log?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff002145),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (!isPunchIn) {
                      await _checkLocationPermission().then((value) async {
                        if (value) {
                          await _addPunchInPunchOutApi(true);
                        }
                      });
                    } else {
                      // Utils.showTopSnackBar('You are already Punched In');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: primaryColor,
                      backgroundColor:
                          !isPunchIn ? Colors.green : Color(0xff002145),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(150, 40)),
                  child: const Text(
                    'Punch In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!isPunchOut) {
                      await _checkLocationPermission().then((value) async {
                        if (value) {
                          await _addPunchInPunchOutApi(false);
                        }
                      });
                    } else {
                      //  Utils.showTopSnackBar('You are already Punched Out');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: primaryWhite,
                      backgroundColor: isPunchIn && !isPunchOut
                          ? Colors.green
                          : Color(0xff002145),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(150, 40)),
                  child: const Text(
                    'Punch Out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPunchInSucessFully(bool isPunchIn) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isPunchIn ? 'Log In Successful!' : 'Log Out Successful!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isPunchIn
                ? Image.asset(
                    'assets/images/punchin.png',
                    width: 80,
                    height: 80,
                  )
                : Image.asset(
                    'assets/images/punchin.png',
                    width: 80,
                    height: 80,
                  ),
            const SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (isPunchIn) {
            //       Navigator.pop(context);
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const AssignmentListPage()));
            //     } else {
            //       Navigator.pop(context);
            //     }
            //   },
            //   style: ElevatedButton.styleFrom(
            //       foregroundColor: primaryWhite,
            //       backgroundColor: primaryColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       minimumSize: const Size(150, 40)),
            //   child: Text(
            //     isPunchIn ? "My Job's" : 'DashBoard',
            //     style: const TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
