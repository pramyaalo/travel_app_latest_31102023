import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Models/CancelledFlightBookingModel.dart';
import '../Models/UnconfirmedBookingModel.dart';
import '../utils/response_handler.dart';

class CancelledBooking extends StatefulWidget {
  const CancelledBooking({Key? key}) : super(key: key);

  @override
  State<CancelledBooking> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CancelledBooking> {
  static Future<List<CancelledFlightBookingModel>?> getPartPaymentData() async {
    List<CancelledFlightBookingModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "UnConfirmedBookingListGet",
        "AgencyId=1107&UserTypeId=2&UserId=1107&Bookingdt=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CancelledFlightBookingModel lm =
              CancelledFlightBookingModel.fromJson(list[i]);
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
                    "Cancelled Flight Booking",
                    style: TextStyle( color: Colors.black,fontFamily: "Montserrat", fontSize: 19),
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
              child: FutureBuilder<List<CancelledFlightBookingModel>?>(
                  future: getPartPaymentData(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .passenger,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 20),
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .bookedOnDt,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image(
                                                                image: AssetImage(
                                                                    'assets/images/tickiconpng.png'),
                                                                width: 16,
                                                                height: 16,
                                                                color: Colors
                                                                    .blue),
                                                            Text(
                                                              "Journey Type: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .journeyType,
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
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
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
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.orange,
                                                        border: Border.all(
                                                            width: 0.1,
                                                            color: Colors
                                                                .blue), //https://stackoverflow.com/a/67395539/16076689
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .bookingStatus,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
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
                                                            color: Colors.blue,
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
                                                            "Trip Date: " +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .tripDate,
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
                                              )
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0xffededed)),
                                                ),
                                              ),
                                              Text(
                                                "Price(Incl. Tax)",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 35,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      Icons.book_outlined,
                                                      size: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      "Booking ID: ",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .bookingId,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].totalAmt,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                  }),
            )));
  }
}
