import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'InvoiceListFlightFareModel.dart';
import 'InvoiceListFlighttaxModel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';
import 'Table1InvoivceFlightReceiptModel.dart';
import 'Table2InvoiceListFlightReceiptModel.dart';
import 'package:http/http.dart' as http;

import 'Table50InvoiceFlightReceiptModel.dart';
import 'Table5InvoiceFlightListReceiptModel.dart';

class InvoiceListReceipt extends StatefulWidget {
  final String Id;

  InvoiceListReceipt({required this.Id});
  @override
  State<InvoiceListReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceListReceipt> {
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
      table50,
      table48,
      table49,
      table20,
      table21;

  List<Table2InvoiceListFlightReceiptModel> tableData2 = [];
  List<Table1InvoivceFlightReceiptModel> tableData1 = [];
  List<Table50InvoiceFlightReceiptModel> tableData50 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListViewGet", "BookFlightId=${widget.Id}");
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
      table48 = map["Table48"];
      table49 = map['Table49'];
      table50 = map['Table50'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Invoice",
                style: TextStyle(fontFamily: "Montserrat", fontSize: 16),
              ),
              //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
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
             backgroundColor: Colors.white,
            ),
            body: Center(
              child: FutureBuilder<String?>(
                  future: getLabels(),
                  builder: (context, snapshot) {
                    print('object' + snapshot.connectionState.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      try {
                        Table0InvoiceFlighteceiptModel m0 =
                            Table0InvoiceFlighteceiptModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0InvoiceFlighteceiptModel.fromJson(
                              table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }
                        tableData1.clear();
                        Table1InvoivceFlightReceiptModel m1 =
                            Table1InvoivceFlightReceiptModel.fromJson(
                                table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            Table1InvoivceFlightReceiptModel t1Data =
                                Table1InvoivceFlightReceiptModel.fromJson(
                                    table1[i]);
                            tableData1.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                          }
                        }
                        tableData2.clear();
                        Table2InvoiceListFlightReceiptModel m2 =
                            Table2InvoiceListFlightReceiptModel.fromJson(
                                table2[0]);
                        if (table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            Table2InvoiceListFlightReceiptModel t1Data =
                                Table2InvoiceListFlightReceiptModel.fromJson(
                                    table2[i]);
                            tableData2.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table2.length}, t1Data: $t1Data');
                          }
                        }

                        tableData50.clear();
                        Table50InvoiceFlightReceiptModel m50 =
                            Table50InvoiceFlightReceiptModel.fromJson(
                                table50[0]);
                        if (table50.isNotEmpty) {
                          for (int i = 0; i < table50.length; i++) {
                            Table50InvoiceFlightReceiptModel t1Data =
                                Table50InvoiceFlightReceiptModel.fromJson(
                                    table50[i]);
                            tableData50.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table50.length}, t1Data: $t1Data');
                          }
                        }
                        InvoiceListFlightFareModel m48 =
                            InvoiceListFlightFareModel.fromJson(table48[0]);
                        if (table48.isNotEmpty) {
                          m48 = InvoiceListFlightFareModel.fromJson(table48[0]);
                          print("fjhg" + m48.totalFare);
                        } else {
                          print('The list is empty.');
                        }

                        InvoiceListFlighttaxModel m49 =
                            InvoiceListFlighttaxModel.fromJson(table49[0]);
                        if (table49.isNotEmpty) {
                          m49 = InvoiceListFlighttaxModel.fromJson(table49[0]);
                          print("fjhg" + m49.totalTax);
                        } else {
                          print('The list is empty.');
                        }

                        Table5InvoiceFlightListReceiptModel m5 =
                            Table5InvoiceFlightListReceiptModel.fromJson(
                                table5[0]);
                        if (table5.isNotEmpty) {
                          m5 = Table5InvoiceFlightListReceiptModel.fromJson(
                              table5[0]);
                          print("fjhg" + m5.phone);
                        } else {
                          print('The list is empty.');
                        }
                        /*    Table7HotelReceiptModel m7 =
                      Table7HotelReceiptModel.fromJson(table7[0]);
                      if (table7.isNotEmpty) {
                        m7 = Table7HotelReceiptModel.fromJson(table7[0]);
                        print("fjhg" + m7.phone);
                      } else {
                        print('The list is empty.');
                      }

                      Table10hotelReceiptModel m10 =
                      Table10hotelReceiptModel.fromJson(table10[0]);
                      if (table10.isNotEmpty) {
                        m10 = Table10hotelReceiptModel.fromJson(table10[0]);
                        print("fjhg" + m10.totalSales);
                      } else {
                        print('The list is empty.');
                      }

                      Table47HotelDetailsModel m47 =
                      Table47HotelDetailsModel.fromJson(table47[0]);
                      if (table47.isNotEmpty) {
                        m47 = Table47HotelDetailsModel.fromJson(table47[0]);
                        print("fjhg" + m47.bookFlightId);
                      } else {
                        print('The list is empty.');
                      }

                      HOtelFareModel m48 =
                      HOtelFareModel.fromJson(table48[0]);
                      if (table48.isNotEmpty) {
                        m48 = HOtelFareModel.fromJson(table48[0]);
                        print("fjhg" + m48.totalFare);
                      } else {
                        print('The list is empty.');
                      }

                      HotelTaxModel m49 = HotelTaxModel.fromJson(table49[0]);
                      if (table49.isNotEmpty) {
                        m49 = HotelTaxModel.fromJson(table49[0]);
                        print("fjhg" + m49.totalTax);
                      } else {
                        print('The list is empty.');
                      }*/
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
                                      Text('Invoice',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Image.asset(
                                          'assets/images/logolatest.png',
                                          width: 200,
                                          height: 50),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Colors.black26,
                                    alignment: Alignment.center,
                                    child: Text('Invoice',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
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
                                          Text(m5.corporateName,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
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
                                            m5.addressLine1 +
                                                m5.addressLine2 +
                                                m5.addressLine3,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text('City:' + m5.city,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Post Code & Phone: ' +
                                                m5.postCode +
                                                "|" +
                                                m5.phone,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Email: ' + m5.email,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Invoice date: ' + m0.bookedOnDt,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Invoice Number: ' +
                                                m0.bookFlightId,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Booking Status: ' +
                                                m0.bookingStatus,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 2,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('   Passenger Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData2.length,
                                        (index) => Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${tableData2[index].passenger}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  Text(
                                                    'Type: ${tableData2[index].type}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Passenger ID: ${tableData2[index].passengerID}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text('Age : 72',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Phone : ${tableData2[index].tfpPhoneNo}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    '	Ticket No : ${tableData2[index].ticketNo}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('   OnWard Segment:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                        children: List.generate(
                                      tableData1.length,
                                      (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Depart: ${tableData1[index].tfsDepAirport}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  Text(
                                                    'Arrival:${tableData1[index].tfsArrAirport}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Depart Date: ${tableData1[index].tfsDepDatedt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      'Flight No: ${tableData1[index].tfsFlightNumber}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Arrival Date: ${tableData1[index].tfsArrDatedt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Duration:  ${tableData1[index].tfsDuration}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3, top: 10),
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        height: 0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('   Payment Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData50.length,
                                        (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '${tableData50[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Input Tax:${tableData50[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Output tax:${tableData50[index].outputTax}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Total Net Amount: ${tableData50[index].totalNett}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Totel Price: ${tableData50[index].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('  Invoice Total (BRL):',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 15, top: 10),
                                          child: Text(
                                            'Remittance:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
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
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Lead Passenger:',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(width: 7),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Text(m2.passenger,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Booking Ref: ' +
                                                      m0.bookingNumber,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Airline:' + m1.tfsAirline,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Start Date: ' +
                                                      m1.tfsDepDatedt,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'End Date: ' +
                                                      m1.tfsArrDatedt,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Total: BRL 5986.00',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3, top: 4),
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                      width: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Base Price',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Text('     :   	',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text(
                                            m48.totalFare,
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
                                                fontWeight: FontWeight.w500)),
                                        Text('       :    	',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text(
                                            m49.totalTax,
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
                                        Text('Total Price ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Text('    :    	',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text('BRL 8650.64',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        // Add more rows for Tax, T Fee, IGST, and Total Price
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('  Terms And Conditions:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
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
                      print('Unexpected errordfdfwreewe');
                      return CircularProgressIndicator();
                    }
                  }),
            )));
  }
}
