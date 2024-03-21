import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/PendingPaymentListModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

class PendingPayment extends StatefulWidget {
  const PendingPayment({Key? key}) : super(key: key);

  @override
  State<PendingPayment> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<PendingPayment> {
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

  static Future<List<PendingPaymentListGet>?> getPartPaymentData() async {
    List<PendingPaymentListGet> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "PendingPaymentListGet",
        "UserId=$userID&UserTypeId=$userTypeID&BookingType=flight");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          PendingPaymentListGet lm = PendingPaymentListGet.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
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
                "Pending Payment",
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
          backgroundColor: Colors.white),
      body: Center(
        child: FutureBuilder<List<PendingPaymentListGet>?>(
          future: getPartPaymentData(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: InkWell(
                          child: PhysicalModel(
                            color: Colors.white,
                            elevation: 8,
                            shadowColor: Color(0xff9a9ce3),
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // Add any other widgets on the right end of the second row

                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payment ID: " +
                                            snapshot.data![index].BookFlightId,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            fontSize: 17),
                                      ),
                                      Text(
                                        "Product: " +
                                            snapshot.data![index].BookingType,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].FullName ?? "",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
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
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Text(
                                              "Date: " +
                                                  snapshot
                                                      .data![index].BookedOnDt,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
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
                                  Text(
                                    "Booking ID: " +
                                        snapshot.data![index].BookFlightId,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Montserrat",
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 230,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                              color: Color(0xffededed)),
                                        ),
                                      ),
                                      Text(
                                        "Price(Incl. Tax)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.book_outlined,
                                              size: 14,
                                            ),
                                            Text(
                                              "UserType: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              snapshot.data![index].UserType,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data![index].BookingAmount}",
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
                          onTap: () {},
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
