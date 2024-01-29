import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Booking/ViewBookingDetails.dart';
import '../Models/CancellBokingQueueModel.dart';
import '../Receipt/InvoiceReceipt.dart';
import '../utils/response_handler.dart';

class CancelBookingQueue extends StatefulWidget {
  const CancelBookingQueue({Key? key}) : super(key: key);

  @override
  State<CancelBookingQueue> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CancelBookingQueue> {
  static Future<List<CancellBokingQueueModel>?>
      getFlightTicketOrderQueue() async {
    List<CancellBokingQueueModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CancelBookingQueueGet",
        "UserTypeId=2&UserId=1107&Bookingdt=&BookFlightId=&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CancellBokingQueueModel lm =
              CancellBokingQueueModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
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
                    "Cancel Booking Queue",
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
                child: FutureBuilder<List<CancellBokingQueueModel>?>(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 10),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].bookingId,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewBookingDetails(),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 3,
                                                                  top: 3),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            2,
                                                                            1,
                                                                            2,
                                                                            1),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  border: Border.all(
                                                                      width:
                                                                          0.1,
                                                                      color: Colors
                                                                          .blue),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.8),
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          5,
                                                                      offset: Offset(
                                                                          0,
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 0),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .bookCardPassenger,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Container(
                                                          width: 250,
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .bookCardDescription,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Text(
                                                          "Booking Date: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .bookedOnDt,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Container(
                                                          width: 320,
                                                          child: Text(
                                                            "Trip Date: " +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .bookCardServiceDt,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  height: 1,
                                                  child: DecoratedBox(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xffededed)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4),
                                                  child: Text(
                                                    "Price(Incl. Tax)",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
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
                                                          snapshot
                                                                      .data![
                                                                          index]
                                                                      .bookCardAmount
                                                                      .length >
                                                                  20
                                                              ? snapshot
                                                                  .data![index]
                                                                  .bookCardAmount
                                                                  .substring(
                                                                      13, 22)
                                                              : snapshot
                                                                  .data![index]
                                                                  .bookCardAmount,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
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
                                                              Receipt(),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          10.0,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.1,
                                                                        color: Colors
                                                                            .blue),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  child: Text(
                                                                    'Invoice',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10.0, 5,
                                                                  10, 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            border: Border.all(
                                                                width: 0.1,
                                                                color: Colors
                                                                    .blue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: Text(
                                                            'Issue',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Text(
                                                      snapshot
                                                                  .data![index]
                                                                  .bookCardAmount
                                                                  .length >
                                                              10
                                                          ? snapshot
                                                              .data![index]
                                                              .bookCardAmount
                                                              .substring(0, 12)
                                                          : snapshot
                                                              .data![index]
                                                              .bookCardAmount,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ])));
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))));
  }
}
