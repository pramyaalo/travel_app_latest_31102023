import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ravel_app_latest_31102023/utils/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'Dashboard.dart';
import 'Models/LoginModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool isLoading = false;
  String MemberId = '';
  String UserName = '', Email = '', Currency = '';
  Future<http.Response>? __futureLogin;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    _showPassword = true;
    _userNameController.text = 'KenyaAgencyCustomer';
    _passwordController.text = 'travel2223';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff74206b), // Dark green color
    ));
    return Scaffold(
        body: Center(
      child: Container(
          height: MediaQuery.of(context).size.height / .1,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Color(0xff74206b), // Replace green color
                BlendMode.hue, // This will change green to pink
              ),
              image: AssetImage('assets/images/loginbg8.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 170), // Adjust the top padding here
                child: Image.asset('assets/images/logo.png',
                    width: 200, height: 100),
              ),
              Text(
                'Login to your Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff74206b),
                ),
              ),
              SizedBox(height: 25),
              Column(
                children: [
                  SizedBox(
                    width: 310,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.grey, // Specify the border color
                          width: 1, // Specify the border width
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(fontSize: 16),

                          icon: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(Icons.people),
                          ),

                          border: InputBorder
                              .none, // Hide the default border of TextField
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 16),
                        controller: _userNameController,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 310,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.grey, // Specify the border color
                          width: 1, // Specify the border width
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(fontSize: 16),
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(Icons.password),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: _showPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 13),
                        ),
                        obscureText: _showPassword,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          print('Alert Dialog Clicked');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xff74206b),
                                  ),
                                  padding: EdgeInsets.only(top: 15, left: 16),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                content: Container(
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: SizedBox(
                                          height: 40,
                                          width: 310,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Enter Username',
                                              hintStyle: TextStyle(),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SizedBox(
                                          height: 45,
                                          width: 310,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //_forgotPassword();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Color(0xff74206b),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              "Forget Password",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          //_forgotPassword();
                          /*  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bankdetails()),
        );*/
                          //_showDialog(context);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff74206b),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: 310,
                          child: ElevatedButton(
                            onPressed: () {
                              print(
                                  'JSON Response: ${_userNameController.text}');
                              __futureLogin = ResponseHandler.performPost(
                                  "B2CLogin",
                                  'Username=' +
                                      _userNameController.text +
                                      '&Password=' +
                                      _passwordController.text);

                              __futureLogin?.then((value) {
                                print('Response body: ${value.body}');

                                String jsonResponse =
                                    ResponseHandler.parseData(value.body);

                                print('JSON Response: ${jsonResponse}');

                                try {
                                  Map<String, dynamic> map =
                                      json.decode(jsonResponse);
                                  List<dynamic> list = map["Table"];
                                  List<dynamic> list1 = map["Table1"];
                                  Table1Model table1Data =
                                      Table1Model.fromJson(list1[0]);
                                  String currency = table1Data.symbol;
                                  print('decodedJsondecodedJson: ${currency}');
                                  print('decodedJson: ${list1}');
                                  LoginModel fm = LoginModel.fromJson(list[0]);
                                  print('decodedJson[0]: ${list[0]}');

                                  Prefs.saveStringValue(
                                      Prefs.PREFS_USER_TYPE, fm.userType);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_USER_TYPE_ID, fm.userTypeId);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_USER_ID, fm.userId);
                                  MemberId = fm.userId;
                                  print('USERID' + MemberId);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_USER_NAME, fm.username);
                                  UserName = fm.username;

                                  Prefs.saveStringValue(
                                      Prefs.PREFS_NAME, fm.name);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_PASSWORD, fm.password);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_TRANSACTION_PASSWORD,
                                      fm.transactionPassword);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_CONTACT_EMAIL,
                                      fm.contactEmail);
                                  Email = fm.contactEmail;
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_MOBILE, fm.mobile);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_TIME_IN, fm.timein);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_TIME_OUT, fm.timeout);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_IS_ACTIVE, fm.isActive);

                                  Prefs.saveStringValue(
                                      Prefs.PREFS_TWO, fm.two);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_PHOTO, fm.photo);

                                  Prefs.saveStringValue(
                                      Prefs.PREFS_PAYPAL, fm.paypal);

                                  Prefs.saveStringValue(
                                      Prefs.PREFS_DATE_CREATED, fm.dateCreated);
                                  Prefs.saveStringValue(
                                      Prefs.PREFS_CURRENCY, table1Data.symbol);
                                  Currency = table1Data.symbol;
                                  print('objeasdfct' + Currency);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(
                                          Username: UserName,
                                          email: Email,
                                          currency: Currency),
                                    ),
                                  );
                                } catch (error) {
                                  // Fluttertoast.showToast(msg: "Login Failed");
                                  log(error.toString());
                                }
                              });
                              log('buttonPress' + _userNameController.text);
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontFamily: "Montserrat"),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 10.0,
                              backgroundColor: Color(0xff74206b),
                              shadowColor: Color(0xff74206b),
                              padding: EdgeInsets.all(10.0),
                              minimumSize: Size(double.infinity, 50.0),
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ]),
          )),
    ));
  }
}
