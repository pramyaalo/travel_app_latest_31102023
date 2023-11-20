import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ravel_app_latest_31102023/utils/response_handler.dart';
import 'package:ravel_app_latest_31102023/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';
import 'Models/LoginModel.dart';

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  String MemberId = '';
  String UserName = '';
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
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffefefef),
        child: Center(
          child: Card(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            color: Colors.white,
            elevation: 16.0,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                          width: 150,
                          image: AssetImage("assets/images/logo.png"))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Login to your Account",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              icon: Icon(Icons.people)),
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          style:
                              TextStyle(fontFamily: "Montserrat", fontSize: 15),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          style:
                              TextStyle(fontFamily: "Montserrat", fontSize: 15),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(fontFamily: "Montserrat"),
                            icon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: _showPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: _showPassword,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontFamily: "Montserrat", color: Colors.blue),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('JSON Response: ${_userNameController.text}');
                            __futureLogin = ResponseHandler.performPost(
                                "B2bLogin",
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
                                print('decodedJson: ${list}');
                                LoginModel fm = LoginModel.fromJson(list[0]);
                                print('decodedJson[0]: ${list[0]}');

                                Prefs.saveStringValue(
                                    Prefs.PREFS_USER_TYPE, fm.UserType);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_USER_TYPE_ID, fm.UserTypeId);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_USER_ID, fm.UserID);
                                MemberId = fm.UserID;
                                print('USERID' + MemberId);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_USER_NAME, fm.Username);
                                UserName = fm.Username;

                                Prefs.saveStringValue(
                                    Prefs.PREFS_NAME, fm.Name);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_PASSWORD, fm.Password);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_TRANSACTION_PASSWORD,
                                    fm.TransactionPassword);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_CONTACT_EMAIL, fm.ContactEmail);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_MOBILE, fm.Mobile);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_TIME_IN, fm.Timein);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_TIME_OUT, fm.Timeout);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_IS_ACTIVE, fm.IsActive);

                                Prefs.saveStringValue(Prefs.PREFS_TWO, fm.Two);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_PHOTO, fm.Photo);

                                Prefs.saveStringValue(
                                    Prefs.PREFS_PAYPAL, fm.Paypal);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_PAYZA, fm.Payza);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_DATE_CREATED, fm.Datecreated);
                                Prefs.saveStringValue(
                                    Prefs.PREFS_CURRENCY, fm.Currency);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
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
                            shadowColor: Colors.blue,
                            primary: Colors.blue,
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(double.infinity, 50.0),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New to AKS Travel? ",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.black87),
                            ),
                            Text(
                              "Join now ",
                              style: TextStyle(
                                  fontFamily: "Montserrat", color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
