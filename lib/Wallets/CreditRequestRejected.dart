import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/response_handler.dart';
import 'CreditRequestRejectedModel.dart';

class CreditRequestRejected extends StatefulWidget {
  const CreditRequestRejected({Key? key}) : super(key: key);

  @override
  State<CreditRequestRejected> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<CreditRequestRejected> {
  static Future<List<CreditRequestRejectedModel>?> getLabels() async {
    List<CreditRequestRejectedModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditBalanceRejectReportGet",
        "UserId=0&UserTypeId=2&TransactionNo=0");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('object' + jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CreditRequestRejectedModel lm =
              CreditRequestRejectedModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        print('osdqwebject' + jsonResponse);
      }
      return bookingCardData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 1,
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 27,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(width: 1), // Set the desired width
                  Text(
                    "Credit Balance Rejected",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: 16),
                  ),
                ],
              ),
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
            body: Center(
              child: FutureBuilder<List<CreditRequestRejectedModel>?>(
                  future: getLabels(),
                  builder: (context, snapshot) {
                    print('objectrtt' + snapshot.connectionState.toString());
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    child: PhysicalModel(
                                      color: Colors.white,
                                      elevation: 8,
                                      shadowColor: const Color(0xff9a9ce3),
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot
                                                            .data![index].name,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    /*  Text(
                                      " 14 January 2023",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),*/
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Authorized By: " +
                                                            snapshot
                                                                .data![index]
                                                                .authorizedName,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    /*  Text(
                                      " 14 January 2023",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),*/
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Type: " +
                                                            snapshot
                                                                .data![index]
                                                                .userType,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    /*  Text(
                                      " 14 January 2023",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500),
                                    ),*/
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 0),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/tickiconpng.png'),
                                                              color:
                                                                  Colors.blue,
                                                              width: 16,
                                                              height: 16,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 0),
                                                            child: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .paymentDate,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10.0, 5, 10, 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFFF7588),
                                                          border: Border.all(
                                                              width: 0.1,
                                                              color: Colors
                                                                  .blue), //https://stackoverflow.com/a/67395539/16076689
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                        ),
                                                        child: Text(
                                                          "Rejected",
                                                          //snapshot.data![index].paidStatus,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 15),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/tickiconpng.png'),
                                                              color:
                                                                  Colors.blue,
                                                              width: 16,
                                                              height: 16,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 15),
                                                            child: Text(
                                                              "Amount: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .depositAmount,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            )));
  }
}
