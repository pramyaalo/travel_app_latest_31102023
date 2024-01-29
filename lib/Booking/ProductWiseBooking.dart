import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Models/ProductwiseBookingListModel.dart';
import '../utils/response_handler.dart';

class AllProductWiseBooking extends StatefulWidget {
  const AllProductWiseBooking({Key? key}) : super(key: key);

  @override
  State<AllProductWiseBooking> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<AllProductWiseBooking> {
  static Future<List<ProductwiseBookingListModel>?> getPartPaymentData() async {
    List<ProductwiseBookingListModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "AllProductwiseBookingListGet",
        "UserTypeId=2&UserId=1107&AgencyId=1107&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ProductwiseBookingListModel lm =
              ProductwiseBookingListModel.fromJson(list[i]);
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
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "ProductWise Booking",
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
          child: FutureBuilder<List<ProductwiseBookingListModel>?>(
              future: getPartPaymentData(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(children: [
                            Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].passenger,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  const IconData(0xe19f,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Product: " +
                                                      snapshot.data![index]
                                                          .bookedProduct,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "TripDate: " +
                                                      snapshot.data![index]
                                                          .tripDate,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10.0, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                    color: _getBackgroundColor(
                                                        snapshot.data![index]
                                                            .bookingStatus),
                                                    border: Border.all(
                                                        width: 0.1,
                                                        color: Colors
                                                            .blue), //https://stackoverflow.com/a/67395539/16076689
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .bookingStatus
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          'assets/images/tickiconpng.png'),
                                                      width: 16,
                                                      height: 16,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      "Paymode:" +
                                                          snapshot.data![index]
                                                              .payMode,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          'assets/images/tickiconpng.png'),
                                                      width: 16,
                                                      height: 16,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .bookedOnDt,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0,
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
                                          height: 35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.book_outlined,
                                                    size: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Booking ID: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 15),
                                                  ),
                                                  Container(
                                                    width: 105,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .bookingId,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data![index]
                                                    .bookCardAmount,
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
                                ),
                                onTap: () {
                                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookingCardMenu()
                    )
                );*/
                                },
                              ),
                            ),
                          ]),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })),
    ));
  }
}

Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'TicketIssued') {
    return Color(0xFF16D39A);
  } else if (bookingStatus == 'Processing') {
    return Color(0xFFFF66CC);
  } else if (bookingStatus == 'Cancelled') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Confirmed') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else {
    return Colors.black;
  }
}
