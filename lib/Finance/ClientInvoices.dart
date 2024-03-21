import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'ClientInvoiceFlightReceipt.dart';
import 'ClientInvoiceHolidayReceipt.dart';
import 'ClientInvoiceHotelReceipt.dart';
import 'ClientInvoiceListReceipt.dart';
import 'ClientInvoiceModel.dart';

class ClientInvoiceList extends StatefulWidget {
  const ClientInvoiceList({Key? key}) : super(key: key);

  @override
  State<ClientInvoiceList> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceList> {
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

  static Future<List<ClientInvoiceModel>?> getLabels() async {
    List<ClientInvoiceModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ClientInvoiceGet",
        "UserTypeId=$userTypeID&UserId=$userID&Status=&BookingNo=&RefferNo=&Bookingdt=&StaffId=0");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        print('jfghhjtyttttgh' + map.toString());
        List<dynamic> list = map["Table"];
        print("fkghgjk" + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          ClientInvoiceModel lm = ClientInvoiceModel.fromJson(list[i]);
          labelData.add(lm);
          print("fkghgjk" + lm.bookingStatus);
        }
      } catch (error) {
        log(error.toString());
      }
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
                "Client Invoice List",
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
          child: FutureBuilder<List<ClientInvoiceModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 7),
                          elevation: 5,
                          shadowColor: Color(0xff9a9ce3),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 290,
                                      child: Text(
                                        snapshot.data![index].paxName1,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                    Container(
                                      width: 290,
                                      child: Text(
                                        snapshot.data![index].bookingType +
                                            " " +
                                            "Details: " +
                                            snapshot.data![index].flightDetails,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 5, 10, 5),
                                          decoration: new BoxDecoration(
                                            color: Colors.orange,
                                            border: Border.all(
                                              width: 0.1,
                                              color: Colors.blue,
                                            ),
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (snapshot.data![index]
                                                      .bookingType ==
                                                  "Flight") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClientInvoiceFlightReceipt(
                                                            Id: snapshot
                                                                .data![index]
                                                                .bookFlightId),
                                                  ),
                                                );
                                              }

                                              if (snapshot.data![index]
                                                      .bookingType ==
                                                  "Holiday") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClientInvoiceHolidayReceipt(
                                                            Id: snapshot
                                                                .data![index]
                                                                .bookFlightId),
                                                  ),
                                                );
                                              }

                                              if (snapshot.data![index]
                                                      .bookingType ==
                                                  "hotel") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClientInvoiceHotelReceipt(
                                                            Id: snapshot
                                                                .data![index]
                                                                .bookFlightId),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .flight, // You can choose an appropriate icon
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "View",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/tickiconpng.png'),
                                              width: 16,
                                              height: 16,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              "Booking Type:" +
                                                  snapshot
                                                      .data![index].bookingType,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/tickiconpng.png'),
                                              width: 16,
                                              height: 16,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              "Booking Date: " +
                                                  snapshot
                                                      .data![index].bookedOnDt,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 246,
                                      height: 1,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Color(0xffededed)),
                                      ),
                                    ),
                                    Text(
                                      "Total Amount",
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
                                          Text(
                                            "Booking ID: " +
                                                snapshot.data![index].bookingId,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Montserrat",
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data![index].totalAmt,
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
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
