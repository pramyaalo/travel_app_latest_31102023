import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/ViewBookingDetails.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'RefundedBookingQueueModel.dart';

class RefundedBookingQueue extends StatefulWidget {
  const RefundedBookingQueue({Key? key}) : super(key: key);

  @override
  State<RefundedBookingQueue> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<RefundedBookingQueue> {
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

  static Future<List<RefundedBookingQueueModel>?>
      getFlightTicketOrderQueue() async {
    List<RefundedBookingQueueModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RefundOnHoldQueueGet",
        "UserTypeId=$userTypeID&UserId=$userID&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          RefundedBookingQueueModel lm =
              RefundedBookingQueueModel.fromJson(list[i]);
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
              "Refunded Booking Queue",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 15),
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
        child: FutureBuilder<List<RefundedBookingQueueModel>?>(
            future: getFlightTicketOrderQueue(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            Column(children: [
                              Card(
                                margin: const EdgeInsets.only(
                                    right: 10, left: 10, top: 7),
                                elevation: 5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              "ID: " +
                                                  snapshot
                                                      .data![index].bookingId,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewBookingDetails(
                                                        id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 3, top: 3),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                2, 1, 2, 1),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          border: Border.all(
                                                              width: 0.1,
                                                              color:
                                                                  Colors.blue),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8),
                                                              spreadRadius: 2,
                                                              blurRadius: 5,
                                                              offset: Offset(0,
                                                                  3), // changes the position of the shadow
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: Text(
                                                          'View',
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
                                              ],
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 0),
                                          child: Container(
                                            width: 320,
                                            child: Text(
                                              snapshot.data![index]
                                                  .bookCardPassenger,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Container(
                                                  width: 250,
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .bookCardDiscription,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(), // Adds space between the two parts of the row
                                        /*   Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/tickiconpng.png'),
                                                  width: 16,
                                                  height: 16,
                                                  color: Colors.blue,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Text(
                                                    "Paid Status: " +
                                                        snapshot.data![index]
                                                            .bookCardDiscription,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  "Booking Date: " +
                                                      snapshot.data![index]
                                                          .bookedOnDt,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Adds space between the two parts of the row
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Container(
                                                  width: 320,
                                                  child: Text(
                                                    "Trip Date: " +
                                                        snapshot.data![index]
                                                            .bookCardServiceDt,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Adds space between the two parts of the row
                                      ],
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
                                          padding:
                                              const EdgeInsets.only(right: 4),
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
                                    Container(
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.book_outlined,
                                                  size: 14,
                                                ),
                                                Text(
                                                  "Booking Type: " +
                                                      snapshot.data![index]
                                                          .bookingType,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5, bottom: 10),
                                            child: Text(
                                              snapshot.data![index].totalRefund,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ]),
                          ])));
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
