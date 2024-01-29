import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Models/ViewTravellerModel.dart';
import '../utils/response_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewTravellerDetails(),
    );
  }
}

class ViewTravellerDetails extends StatefulWidget {
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<ViewTravellerDetails> {
  String checkboxStatus = "0";
  String checkboxStatus1 = "0";
  List<ViewTravellerModel> table1Data = [];
  bool isIssueTicketChecked = false;
  bool isCancelBookingChecked = false;
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;
  Future<String?> getInvoiceReceiptJSON() async {
    Future<http.Response>? futureLabels =
        ResponseHandler.performPost("TravellerViewGet", "TravellerID=2497");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];
      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }

  String _userImage = '';
  String datePart = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "View Traveller Details",
              style: TextStyle( color: Colors.black,fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
       backgroundColor: Colors.white,
      ),
      body: Center(
          child: FutureBuilder<String?>(
              future: getInvoiceReceiptJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  try {
                    log('Datagfggg: :${snapshot.data}');
                    Table0 m0 = Table0.fromJson(table0[0]);
                    Tablee1 m1 = Tablee1.fromJson(table1[0]);
                    Tablee2 m2 = Tablee2.fromJson(table2[0]);

                    Tablee3 m3 = Tablee3.fromJson(table3[0]);
                    Tablee4 m4 = Tablee4.fromJson(table4[0]);
                    Tablee5 m5 = Tablee5.fromJson(table5[0]);
                    Tablee6 m6 = Tablee6.fromJson(table6[0]);
                    String dateTimeString = m1.pdDateOfBirth;
                    datePart = dateTimeString.substring(0, 10);
                    String dateTimeString1 = m3.ddDOBdt;
                    datePart = dateTimeString.substring(0, 10);
                    log('Datagrrwwfggg: :${m6}');
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 9, right: 9, top: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(
                              8.0)), // Optional: Add rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Travellers",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                print('Button Clicked');
                                //_showSelectionDialog(context);
                              },
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    // Adjust the size as needed
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/profile.png', // Replace with your placeholder image asset path
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.camera_alt),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Language",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.language,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    State",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.state,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Customer Type",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.customerType,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Title",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDTitle,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Last Name",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDLastName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Residency",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDResistance,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Post Code",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.postCode,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Customer Name",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.customerName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    First Name",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDFirstName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Gender",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.gender,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Street Address",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.streetAddress,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Traveller Type",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDTravellerType,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Traveller Code",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.travellerId,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Middle Name",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDMiddName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Email",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDEMailID,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    City",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m0.uDStatus,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "User Credentials",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    UserName",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.uDUserName,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Password",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.uDPassword,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Contact Details",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Country Code",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.language,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Area Code",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.state,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Area Code",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.language,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Phone Number",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.state,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      "    Mobile Number",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Center(
                                    child: Text(" : "),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      m0.state,
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Passport",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, top: 7),
                              elevation: 5,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "Document: " + m1.pdDocument,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Passport No: " +
                                                    m1.pdPassportNo,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "DOB: " + datePart.toString(),
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Expiry: " + m1.pdDateOfExpirydt,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/tickiconpng.png'),
                                            width: 16,
                                            height: 16,
                                            color: Colors.blue,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "Primary: " + m1.pdIsPrimary,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Nationality: " + m1.pdNationality,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/tickiconpng.png'),
                                            width: 16,
                                            height: 16,
                                            color: Colors.blue,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              m1.pdIssuingCountry,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Visa",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, top: 7),
                              elevation: 5,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "Visa No: " + m2.traVisaId,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Type Of Visa: " +
                                                    m2.vdTypeOfVisa,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Country Of Visa: " +
                                                    m2.vdCountryOfVisa,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Expiry: " + m2.vdDateOfExpiry,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Dependant",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, top: 7),
                              elevation: 5,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "Name: " +
                                              m3.ddTitleId +
                                              " " +
                                              m3.ddFirstName +
                                              m3.ddMiddleName +
                                              m3.ddLastName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Passport No: " +
                                                    m3.ddPassportNo,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/tickiconpng.png'),
                                            width: 16,
                                            height: 16,
                                            color: Colors.blue,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "DOB: " + m3.ddDOBdt,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Expiry: " + m3.ddDateOfExpirydt,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/tickiconpng.png'),
                                            width: 16,
                                            height: 16,
                                            color: Colors.blue,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "Relation: " + m3.ddRelation,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Nationality: " + m3.ddNationality,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Card",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, top: 7),
                              elevation: 5,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "Name On Card: " + m4.nameOnCard,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Card Name: " + m4.cardName1,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Card Type: " + m4.cardType1,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Card Number: " + m4.cardNumber,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Spacer(), // Adds space between the two parts of the row
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Expiry: " +
                                              m4.expiryMonth +
                                              " " +
                                              m4.expiryYear,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    LH Seat Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apLonghaulSeatName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    SH Seat Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apShorthaulSeatName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Meal Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.mealPreference,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Other Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apOther,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Stop Over Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apStopOverName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Max Layout Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apMaxLayoutName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Class Preference",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              m5.apClass,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } catch (error) {
                    print('Unexpected error: $error');
                    return Text('An unexpected error occurred.');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}

Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0), // Adjust the bottom padding
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    ),
  );
}
