import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/response_handler.dart';
import 'CreditBalanceApprovaalModel.dart';

class CreditBalanceApproval extends StatefulWidget {
  const CreditBalanceApproval({Key? key}) : super(key: key);

  @override
  State<CreditBalanceApproval> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<CreditBalanceApproval> {
  Future<http.Response>? __futureLogin;
  static Future<List<CreditBalanceApprovaalModel>?> getLabels() async {
    List<CreditBalanceApprovaalModel> labelData = [];
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "CreditBalanceApprovalGet", "UserId=0&UserTypeId=2&TransactionNo=0");

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log('hjgfhjyfgjhyg' + jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CreditBalanceApprovaalModel lm =
              CreditBalanceApprovaalModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {}
      return labelData;
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
                    "Credit Balance Approval",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: 17),
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
              child: FutureBuilder<List<CreditBalanceApprovaalModel>?>(
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
                                                          left: 0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10.0, 5, 10, 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              _getBackgroundColor(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .status),
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
                                                                  "0"
                                                              ? "Pending"
                                                              : "Reject",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 310,
                                                  height: 1,
                                                  child: DecoratedBox(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xffededed)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                __futureLogin =
                                                    ResponseHandler.performPost(
                                                        "CreditBalanceApproveSet",
                                                        'UserId=0&UserTypeId=2&ManageDepositId=' +
                                                            snapshot
                                                                .data![index]
                                                                .manageDepositId);
                                                print(
                                                    'Response body: ${snapshot.data![index].manageDepositId}');
                                                __futureLogin?.then((value) {
                                                  print(
                                                      'Response bosdddy: ${value.body}');

                                                  String jsonResponse =
                                                      ResponseHandler.parseData(
                                                          value.body);

                                                  print(
                                                      'JSON Respertttonse: ghhj ${jsonResponse}');
                                                });
                                                setState(() {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          CreditBalanceApproval(),
                                                    ),
                                                  );
                                                });
                                              },
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
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
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
                                                            padding: EdgeInsets
                                                                .fromLTRB(10.0,
                                                                    5, 10, 5),
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
                                                              "Approve",
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        __futureLogin = ResponseHandler.performPost(
                                                            "CreditBalanceRejectSet",
                                                            'ManageDepositId=' +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .manageDepositId);
                                                        print(
                                                            'Response body: ${snapshot.data![index].manageDepositId}');
                                                        __futureLogin
                                                            ?.then((value) {
                                                          print(
                                                              'Response bosdddy: ${value.body}');

                                                          String jsonResponse =
                                                              ResponseHandler
                                                                  .parseData(
                                                                      value
                                                                          .body);

                                                          print(
                                                              'JSON Respertttonse: ghhj ${jsonResponse}');
                                                        });
                                                        setState(() {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  CreditBalanceApproval(),
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10.0,
                                                                          5,
                                                                          10,
                                                                          5),
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
                                                                "Reject",
                                                                //snapshot.data![index].paidStatus,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontSize:
                                                                        15,
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
            )));
  }
}

Color _getBackgroundColor(String Status) {
  if (Status == '0') {
    return Color(0xFFFF7588);
  } else {
    return Colors.greenAccent;
  }
}
