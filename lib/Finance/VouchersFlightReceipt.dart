import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/response_handler.dart';
import 'Flight_VouchersListModel.dart';
import 'Table1FLightModel.dart';
import 'Table2FlightModel.dart';
import 'Table3FareBreakDoenFlightModel.dart';

class VouchersReceipt extends StatefulWidget {
  final String Id;

  VouchersReceipt({required this.Id});
  @override
  State<VouchersReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table34,
      table39,
      table40,
      table20,
      table21;

  List<Flight_VouchersListModel> tableData = [];
  List<Table1FLightModel> tableData1 = [];
  List<Table2FlightModel> tableData2 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "VoucherViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table34 = map['Table34'];
      return jsonResponse;
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
                  "Vouchers Receipt",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontSize: 17.5),
                ),
              ],
            ),
            actions: [
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 50,
              ),
              SizedBox(
                width: 10,
              )
            ],
            backgroundColor: Colors.white),
        body: Center(
          child: FutureBuilder<String?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  try {
                    Flight_VouchersListModel m0 =
                        Flight_VouchersListModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Flight_VouchersListModel.fromJson(table0[0]);
                      print("fjhg" + m0.bookFlightId);
                    } else {
                      print('The list is empty.');
                    }

                    Table1FLightModel m1 =
                        Table1FLightModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      m1 = Table1FLightModel.fromJson(table1[0]);
                      print("fjhg" + m1.tfsClassName);
                    } else {
                      print('The list is empty.');
                    }

                    Table2FlightModel m2 =
                        Table2FlightModel.fromJson(table2[0]);
                    if (table2.isNotEmpty) {
                      m2 = Table2FlightModel.fromJson(table2[0]);
                      print("fjhg" + m2.ticketNo);
                    } else {
                      print('The list is empty.');
                    }

                    Table3FareBreakDoenFlightModel m3 =
                        Table3FareBreakDoenFlightModel.fromJson(table3[0]);
                    if (table3.isNotEmpty) {
                      m3 = Table3FareBreakDoenFlightModel.fromJson(table3[0]);
                      print("fjhg" + m3.totalSales);
                    } else {
                      print('The list is empty.');
                    }
                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('BOOKING VOUCHER',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Image.asset('assets/images/logolatest.png',
                                      width: 150, height: 50),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date and Thank you message
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Date: " + m0.bookedOnDt,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text("Dear " + m2.passenger,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  15)), // Your date widget goes here
                                      Text(
                                          "Thank you for booking with Travel Demo.Our preferred partner would like to invite you to join a paid subscription service for access to discount offers.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text("Reference number: " + m0.ticketNo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                          "Please print and take this booking confirmation with you to the airport. It may speed up your check-in experience.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                          "For any concerns/queries related to this booking, please mention this reference number in all your future communications with us.You can contact us toll-free on: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text(
                                          "Booking Status: " + m0.bookingStatus,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFF8C8DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Passenger(s)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(m2.passenger,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        'Type: ' + m2.type,
                                        style: (TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Passenger ID: ' + m2.passengerId,
                                          style: (TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                      Text('Age : 72',
                                          style: (TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Phone:  ' + m2.custPhone,
                                          style: (TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15))),
                                      Text(
                                        '	Ticket No: ' + m2.ticketNo,
                                        style: (TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFF8C8DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '   OnWard Airlines Information:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15, top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Depart: ' + m1.tfsDepAirport,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              'Arrival: ' + m1.tfsArrAirport,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15, top: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '	Depart Date: ' +
                                                    m1.tfsDepDateDt,
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15))),
                                            Text(
                                                '	Flight No: ' +
                                                    m1.tfsFlightNumber,
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15))),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15, top: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '	Arrival Date: ' +
                                                    m1.tfsArrDateDt,
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15))),
                                            Text(
                                              '	Duration: ' + m1.tfsDuration,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFF8C8DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Payment Information:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                  width: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Total Fare',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text('     :   	',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        m3.totalSales,
                                      ),
                                    ),
                                    // Add more rows for Tax, T Fee, IGST, and Total Price
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Total Tax',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text('       :    	',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        'BRL 2129.90',
                                      ),
                                    ),
                                    // Add more rows for Tax, T Fee, IGST, and Total Price
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('NET PAYABLE  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18)),
                                    Text('    :    	',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                        'BRL 5986.00',
                                      ),
                                    ),
                                    // Add more rows for Tax, T Fee, IGST, and Total Price
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 10),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 0),
                                        width: 280,
                                        child: Text(
                                          '* BAGGAGE DISCOUNTS MAY APPLY BASED ON FREQUENT FLYER STATUS/ONLINE CHECKIN/FORM OF PAYMENT/MILITARY/ETC.',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 0),
                                        width: 280,
                                        child: Text(
                                          '* REMAINGING PAYMENT HAS TO BE DONE WHEN PICKING BUS.',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFF8C8DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Terms And Conditions:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'This is a computer-generated Invoice and Digitally signed.',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } catch (error) {
                    print('Unexpected error: $error');
                    return Text('An unexpected error occurred.');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
