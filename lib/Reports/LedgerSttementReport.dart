import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

class LedgerSttementReport extends StatefulWidget {
  const LedgerSttementReport({Key? key}) : super(key: key);

  @override
  State<LedgerSttementReport> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<LedgerSttementReport> {
/*  static Future<List<WalletReportModel>?> getLabels() async {
    List<WalletReportModel> labelData = [];
    Future<http.Response>? futureLabels = ResponseHandler.performPost_OLD(
        "WalletStatementReport_Get",
        "CorporateId=1001&FromDate=&ToDate=&BookingType=ALL");

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          WalletReportModel lm = WalletReportModel.fromMap(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
      return labelData;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Ledger Statement Report",
                style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
              ),
              //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
              actions: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                )
              ],
              backgroundColor: Color(0xFF152238),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : 27-Nov-2022",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconData(0xefc6,
                                          fontFamily: 'MaterialIcons'),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Debit : 100.00",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffededed)),
                                  ),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.book_outlined,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Booking ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "1001",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹5899.50",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
