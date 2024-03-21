import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'FinanicialBookModel.dart';

class FinancialBook extends StatefulWidget {
  const FinancialBook({Key? key}) : super(key: key);

  @override
  State<FinancialBook> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<FinancialBook> {
  static late String userTypeID;
  static late String userID;
  static late String Currency;

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
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  static Future<List<FinanicialBookModel>?> getLabels() async {
    List<FinanicialBookModel> labelData = [];
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "FinancialBookGet",
        "UserTypeId=$userTypeID&UserId=$userID&FinancialBookId=1&fromdate=&Todate=");

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          FinanicialBookModel lm = FinanicialBookModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {}
      return labelData;
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
                "Financial Book",
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
          child: FutureBuilder<List<FinanicialBookModel>?>(
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
                                                const Text("Name: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot
                                                      .data![index].userName,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Montserrat",
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
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot.data![index].credit,
                                                  style: const TextStyle(
                                                      fontFamily: "Montserrat",
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
                                              MainAxisAlignment.spaceBetween,
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
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot.data![index].debit,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Montserrat",
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
                                                const Text("Account Type: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot.data![index]
                                                      .accountTypeName,
                                                  style: const TextStyle(
                                                      fontFamily: "Montserrat",
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Type: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot
                                                      .data![index].userType,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Montserrat",
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
                                                const Text("Transaction No: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  snapshot
                                                      .data![index].serialNo,
                                                  style: const TextStyle(
                                                      fontFamily: "Montserrat",
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
                                            const Text("Transaction Date: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index].date,
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
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
        ));
  }
}
