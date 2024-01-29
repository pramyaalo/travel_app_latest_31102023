import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/response_handler.dart';
import 'FundTransferHistoryModel.dart';

class FundTransferHistory extends StatefulWidget {
  const FundTransferHistory({Key? key}) : super(key: key);

  @override
  State<FundTransferHistory> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<FundTransferHistory> {
  static Future<List<FundTransferHistoryModel>?> getLabels() async {
    List<FundTransferHistoryModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "FundTransferHistoryGet", "UserId=1107&UserTypeId=2");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          FundTransferHistoryModel lm =
              FundTransferHistoryModel.fromJson(list[i]);
          labelData.add(lm);
        }
        Map<String, dynamic> table1Data = map["Table1"];
        List<dynamic> table1List = table1Data["Table1"];
        for (int i = 0; i < table1List.length; i++) {
          FundTransferHistoryModel lm =
              FundTransferHistoryModel.fromJson(list[i]);
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
                    "Fund Transfer History",
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
              child: FutureBuilder<List<FundTransferHistoryModel>?>(
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
                                                    const Text("From: ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      snapshot.data![index]
                                                          .TransferFrom,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text("Credit: ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      snapshot.data![index]
                                                              .Currency +
                                                          snapshot.data![index]
                                                              .Credit1,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
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
                                                    const Text("Debit: ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      snapshot.data![index]
                                                              .Currency +
                                                          snapshot.data![index]
                                                              .Debit1,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text("To: ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      snapshot.data![index]
                                                          .TransferTo,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Message: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Expanded(
                                                  child: Text(
                                                    snapshot
                                                        .data![index].Message,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
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
