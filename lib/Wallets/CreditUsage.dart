import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/BookingCard.dart';
import '../utils/response_handler.dart';
import 'CreditBalanceApproval.dart';
import 'CreditBalanceRequest.dart';
import 'CreditRequestReceipt.dart';
import 'CreditUsageModel.dart';
import 'FundReceivedHistory.dart';
import 'FundTransfer.dart';
import 'FundTransferHistory.dart';

class CreditUsage extends StatefulWidget {
  const CreditUsage({Key? key}) : super(key: key);

  @override
  State<CreditUsage> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditUsage> {
  late List<dynamic> table0, table1, table4, table11;
  /* List<Table0ProfitandLossModel> tableData = [];
  List<Table1ProfitandLossModel> tableData1 = [];
  List<Table1ProfitandLossModel> tableData11 = [];
  List<Table4ProfitandLossModel> tableData4 = [];*/
  Future<String?> getInvoiceReceiptJSON() async {
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "CreditUsageGet", "UserId=1107&UserTypeId=2");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];

      table4 = map["Table4"];

      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }
  /* Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels1 = ResponseHandler.performPost(
        "ProfitLossGet",
        "UserTypeId=2&UserId=1107&Period=0&fromdate=&Todate=&AccountingHeadId=3");

    // Wait for the first API call to complete
    await __futureLabels1?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table4 = map['Table4'];

      return jsonResponse;
    });

    // Now make the second API call
    Future<http.Response>? __futureLabels2 = ResponseHandler.performPost(
        "ProfitLossGet",
        "UserTypeId=2&UserId=1107&Period=0&fromdate=&Todate=&AccountingHeadId=4");

    return await __futureLabels2?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];

      table4 = map['Table4'];
      table11 = map['Table1'];
      return jsonResponse;
    });
  }*/

  var selectedDate = DateTime.now().obs;
  TextEditingController dateController = TextEditingController();
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "CREDIT USAGE",
          style: TextStyle(fontFamily: "Montserrat", fontSize: 16),
        ),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
             width: 120,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
       backgroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder<String?>(
            future: getInvoiceReceiptJSON(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  CreditUsageModel m0 = CreditUsageModel.fromJson(table0[0]);
                  if (table0.isNotEmpty) {
                    m0 = CreditUsageModel.fromJson(table0[0]);
                    print("ffrtt5jhg" + m0.totalCredit);
                  } else {
                    print('The list is empty.');
                  }
                  log('Datagfggg: :${snapshot.data}');

                  return SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.all(0),
                          child: InkWell(
                              child: PhysicalModel(
                            color: Colors.white,
                            elevation: 8,
                            shadowColor: Color(0xff9a9ce3),
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    child: Text('Credit Usage',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Text(
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        'Status related to your Available Wallet Balance,Today Usage, Used Wallet & Total Credits'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Material(
                                          elevation: 10,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Color(0xff41d1d1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Total Credits',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  m0.totalCredit,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Material(
                                          elevation: 10,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Color(0xff3050af),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Wallet Balance',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  m0.creditLeft,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Material(
                                          elevation: 10,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Color(0xffeb8899),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Used Wallet',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  m0.usedCredit,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Material(
                                          elevation: 10,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Color(0xffe7a236),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Today Usage',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  m0.todayUsage,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Text('Booking Activity',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        'Status related to your Available Wallet Balance,Today Usage, Used Wallet & Total Credits'),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingCard()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('All Booking',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 44,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FundReceivedHistory()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Transfer Received',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 16), // Add space between buttons
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              /*  Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NextPage()),
                                              );*/
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Withdraw Fund',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 44,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FundTransferHistory()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Transfer History',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 16), // Add space between buttons
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FundTransfer()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Fund Transfer',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 44,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreditBalanceRequest()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Balance Request',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 16), // Add space between buttons
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreditBalanceApproval()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Balance Approval',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 44,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BalanceReceipt()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromHeight(55),
                                              primary: Color(
                                                  0xFF1d5e72), // Set background color to blue
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    13.0), // Set circular shape
                                              ),
                                              elevation:
                                                  9.0, // Set elevation radius
                                            ),
                                            child: Text('Balance Receipt',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))));
                } catch (error) {
                  print('Unexpected error: $error');
                  return Text('An unexpected error occurred.');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    ));
  }
}
