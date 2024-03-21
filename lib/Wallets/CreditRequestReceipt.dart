import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditRequestReceiptModel.dart';
import 'ViewCreditRequestReceipt.dart';

class BalanceReceipt extends StatefulWidget {
  const BalanceReceipt({Key? key}) : super(key: key);

  @override
  State<BalanceReceipt> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<BalanceReceipt> {
  static late String userTypeID;
  static late String userID;
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  static Future<List<CreditRequestReceiptModel>?> getLabels() async {
    List<CreditRequestReceiptModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditBalanceReceiptGet",
        "UserId=$userID&UserTypeId=$userTypeID&TransactionNo=0");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('object' + jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CreditRequestReceiptModel lm =
              CreditRequestReceiptModel.fromJson(list[i]);
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
    return Scaffold(
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
                "Balance Receipt",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 19),
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
          child: FutureBuilder<List<CreditRequestReceiptModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data![index].name,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                        snapshot.data![index]
                                                            .authorizedName,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Type: " +
                                                        snapshot.data![index]
                                                            .userType,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                              padding: const EdgeInsets.only(
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
                                                          color: Colors.blue,
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
                                                          snapshot.data![index]
                                                              .paymentDate,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.blue),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Payment: " +
                                                        snapshot.data![index]
                                                            .payment,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                              padding: const EdgeInsets.only(
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
                                                          color: Colors.blue,
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
                                                          "Amount: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .depositAmount,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 310,
                                              height: 1,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffededed)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 35,
                                            margin: EdgeInsets.only(top: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.book_outlined,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        "Deposit ID: ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .manageDepositId,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                                                          color: Colors
                                                              .greenAccent,
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
                                                          snapshot.data![index]
                                                                      .status ==
                                                                  "1"
                                                              ? "Approved"
                                                              : "NotApproved",
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewCreditRequestReceipt(
                                                                Id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .manageDepositId),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10.0, 5,
                                                                  10, 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFFF7588),
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
                                                            "View",
                                                            //snapshot.data![index].paidStatus,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
        ));
  }
}

Color _getBackgroundColor(String Status) {
  if (Status == '0') {
    return Color(0xFFFF7588);
  } else {
    return Colors.greenAccent;
  }
}
