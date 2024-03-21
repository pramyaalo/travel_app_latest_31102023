import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'FundReceivedHistoryModel.dart';

class FundReceivedHistory extends StatefulWidget {
  const FundReceivedHistory({Key? key}) : super(key: key);

  @override
  State<FundReceivedHistory> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<FundReceivedHistory> {
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

  static Future<List<FundReceivedHistoryModel>?> getLabels() async {
    List<FundReceivedHistoryModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "FundTransferReceivedGet",
        "UserId=$userID&UserTypeId=$userTypeID&FromDate=&ToDate=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          FundReceivedHistoryModel lm =
              FundReceivedHistoryModel.fromJson(list[i]);
          labelData.add(lm);
        }
        Map<String, dynamic> table1Data = map["Table1"];
        List<dynamic> table1List = table1Data["Table1"];
        for (int i = 0; i < table1List.length; i++) {
          FundReceivedHistoryModel lm =
              FundReceivedHistoryModel.fromJson(list[i]);
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
                "Fund Received History",
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
          child: FutureBuilder<List<FundReceivedHistoryModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/orderpng2.webp"),
                                      width: 70,
                                      height: 80,
                                      color: Color(0xffd473d4),
                                    ),
                                    SizedBox(
                                        width:
                                            10), // Add SizedBox to create space between the image and text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].customerName,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                "Received Amount: " +
                                                    snapshot
                                                        .data![index].credit,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.5),
                                          Row(
                                            children: [
                                              Text(
                                                "Received Date: ${snapshot.data![index].dateCreated}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    height: 1,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffededed)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Text(
                                      "Price(Incl. Tax)",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.book_outlined,
                                      size: 14,
                                    ),

                                    Text(
                                      'ID: ${snapshot.data![index].id}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    Spacer(), // Add Spacer to push the text to the right end
                                    Text(
                                      snapshot.data![index].balance,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
