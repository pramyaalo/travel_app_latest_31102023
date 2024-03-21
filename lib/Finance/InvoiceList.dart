import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'InvoiceFlightListReceipt.dart';
import 'InvoiceHolidayReceipt.dart';
import 'InvoiceHotelReceipt.dart';
import 'InvoiceReceiptModel.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceList> {
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

  static Future<List<InvoiceReceiptModel>?> getLabels() async {
    List<InvoiceReceiptModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListGet",
        "UserTypeId=$userTypeID&UserId=$userID&Status=&BookingNo=&RefferNo=&Bookingdt=&StaffId=");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        print('jfghhjtyttttgh' + map.toString());
        List<dynamic> list = map["Table"];
        print("fkghgjk" + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          InvoiceReceiptModel lm = InvoiceReceiptModel.fromJson(list[i]);
          labelData.add(lm);
          print("fkghgjk" + lm.bookingAmount);
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
                "Invoice List",
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
          child: FutureBuilder<List<InvoiceReceiptModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 7),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].passenger,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 320,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              snapshot.data![index]
                                                  .originDestination,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          const IconData(0xefc6,
                                              fontFamily: 'MaterialIcons'),
                                          size: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(
                                            "Product: " +
                                                snapshot
                                                    .data![index].bookedProduct,
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
                                  Row(
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
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Journey Type: " +
                                              snapshot.data![index].journeyType,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                  GestureDetector(
                                    onTap: () {
//InvoiceListReceipt
                                      if (snapshot.data![index].bookedProduct ==
                                          "Flight") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceListReceipt(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }
                                      if (snapshot.data![index].bookedProduct ==
                                          "Hotel") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceHotelReceipt(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }

                                      if (snapshot.data![index].bookedProduct ==
                                          "Car") {
                                        /*  Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VouchersCarReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );*/
                                      }
                                      if (snapshot.data![index].bookedProduct ==
                                          "Holiday") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceHolidayReceipt(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }
                                      if (snapshot.data![index].bookedProduct ==
                                          "Bus") {}
                                      /* Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VouchersBusReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }*/
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 5, 10, 5),
                                            decoration: new BoxDecoration(
                                              color: Colors.orange,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: Colors
                                                      .blue), //https://stackoverflow.com/a/67395539/16076689
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(
                                                      0.4), // Set the shadow color
                                                  spreadRadius:
                                                      2, // Set the spread radius of the shadow
                                                  blurRadius:
                                                      4, // Set the blur radius of the shadow
                                                  offset: Offset(0,
                                                      2), // Set the offset of the shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              "Receipt",
                                              //snapshot.data![index].paidStatus,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Text(
                                                "Booking Date: " +
                                                    snapshot.data![index]
                                                        .bookedOnDt,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.blue),
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
                                      decoration: const BoxDecoration(
                                          color: Color(0xffededed)),
                                    ),
                                  ),
                                  Text(
                                    "Price(Incl. Tax)",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.book_outlined,
                                          size: 12,
                                        ),
                                        Text(
                                          "Booking ID: ",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          snapshot.data![index].bookFlightId,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        snapshot.data![index].totalAmt,
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
