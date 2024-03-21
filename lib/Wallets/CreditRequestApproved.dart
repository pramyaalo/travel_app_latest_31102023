import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditRequestApprovedModel.dart';

class CreditRequestApproved extends StatefulWidget {
  const CreditRequestApproved({Key? key}) : super(key: key);

  @override
  State<CreditRequestApproved> createState() => _WalletStatementReportState();
}

class _WalletStatementReportState extends State<CreditRequestApproved> {
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

  static Future<List<CreditRequestApprovedModel>?> getLabels() async {
    List<CreditRequestApprovedModel> labelData = [];
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "CreditBalanceApprovedReportGet",
        "UserId=$userID&UserTypeId=$userTypeID&TransactionNo=0");

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CreditRequestApprovedModel lm =
              CreditRequestApprovedModel.fromJson(list[i]);
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
                "Balance Approved",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 18),
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
          child: FutureBuilder<List<CreditRequestApprovedModel>?>(
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
                                            snapshot.data![index].name,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                "Transaction No: " +
                                                    snapshot.data![index]
                                                        .transactionNo,
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
                                                "Authorized By: ${snapshot.data![index].authorizedName}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10.0, 5, 10, 5),
                                                      decoration: BoxDecoration(
                                                        color: snapshot
                                                                    .data![
                                                                        index]
                                                                    .approval ==
                                                                '1'
                                                            ? Colors
                                                                .greenAccent // Green for approved
                                                            : Colors
                                                                .red, // Red for not approved
                                                        border: Border.all(
                                                          width: 0.1,
                                                          color: Colors.blue,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Text(
                                                        snapshot.data![index]
                                                                    .approval ==
                                                                '1'
                                                            ? "Approved"
                                                            : "Not Approved",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/tickiconpng.png",
                                                    cacheWidth: 15,
                                                    cacheHeight: 15,
                                                  ),
                                                  Text(
                                                      textAlign: TextAlign.end,
                                                      snapshot.data![index]
                                                          .paymentDate,
                                                      //Text(snapshot.data![index].username,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.book_outlined,
                                      size: 14,
                                    ),
                                    Text(
                                      'ID: ${snapshot.data![index].manageDepositId}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      snapshot.data![index].currencyCode +
                                          snapshot.data![index].depositAmount,
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

Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'Approved') {
    return Color(0xFF16D39A);
  } else if (bookingStatus == 'Not Approved') {
    return Color(0xFFFF66CC);
  } else if (bookingStatus == 'Cancelled') {
    return Colors.red;
  } else if (bookingStatus == 'Confirmed') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'CONFIRMED') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Booked') {
    return Color(0xFFFF7588);
  } else {
    return Color(0xFF16D39A);
  }
}
