import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'InvoiceListFlightFareModel.dart';
import 'InvoiceListFlighttaxModel.dart';
import 'InvoiceListHotelFareModel.dart';
import 'OInvoiceListHoteltaxModel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';
import 'Table10InvoiceHotelfareBreakdownListModel.dart';
import 'Table11InvoiceHotelreceiptModel.dart';
import 'Table1InvoivceFlightReceiptModel.dart';
import 'Table2InvoiceListFlightReceiptModel.dart';
import 'package:http/http.dart' as http;

import 'Table47InvoiceHotelListModel.dart';
import 'Table50InvoiceFlightReceiptModel.dart';
import 'Table5InvoiceFlightListReceiptModel.dart';
import 'Table7InvoiceListHotelModel.dart';
import 'Table9InvoiceListHotelModel.dart';

class InvoiceHotelReceipt extends StatefulWidget {
  final String Id;

  InvoiceHotelReceipt({required this.Id});
  @override
  State<InvoiceHotelReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceHotelReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table7,
      table8,
      table9,
      table10,
      table11,
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
      table47,
      table48,
      table49,
      table20,
      table21;

  List<Table7InvoiceListHotelModel> tableData7 = [];
  List<Table9InvoiceListHotelModel> tableData9 = [];
  List<Table10InvoiceHotelfareBreakdownListModel> tableData10 = [];

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
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table34 = map['Table34'];
      table47 = map["Table47"];
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
                        tableData9.clear();
                        Table9InvoiceListHotelModel m9 =
                            Table9InvoiceListHotelModel.fromJson(table9[0]);
                        if (table9.isNotEmpty) {
                          for (int i = 0; i < table9.length; i++) {
                            Table9InvoiceListHotelModel t1Data =
                                Table9InvoiceListHotelModel.fromJson(table9[i]);
                            tableData9.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table9.length}, t1Data: $t1Data');
                          }
                        }
                        tableData7.clear();
                        Table7InvoiceListHotelModel m7 =
                            Table7InvoiceListHotelModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          for (int i = 0; i < table7.length; i++) {
                            Table7InvoiceListHotelModel t1Data =
                                Table7InvoiceListHotelModel.fromJson(table7[i]);
                            tableData7.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                          }
                        }

                        Table11InvoiceHotelreceiptModel m11 =
                            Table11InvoiceHotelreceiptModel.fromJson(
                                table11[0]);
                        if (table11.isNotEmpty) {
                          m11 = Table11InvoiceHotelreceiptModel.fromJson(
                              table11[0]);
                          print("fjhg" + m11.phone);
                        } else {
                          print('The list is empty.');
                        }
                        /* tableData2.clear();
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
                        }*/

                        tableData10.clear();
                        Table10InvoiceHotelfareBreakdownListModel m10 =
                            Table10InvoiceHotelfareBreakdownListModel.fromJson(
                                table10[0]);
                        if (table10.isNotEmpty) {
                          for (int i = 0; i < table10.length; i++) {
                            Table10InvoiceHotelfareBreakdownListModel t1Data =
                                Table10InvoiceHotelfareBreakdownListModel
                                    .fromJson(table10[i]);
                            tableData10.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table10.length}, t1Data: $t1Data');
                          }
                        }
                        InvoiceListHotelFareModel m48 =
                            InvoiceListHotelFareModel.fromJson(table48[0]);
                        if (table48.isNotEmpty) {
                          m48 = InvoiceListHotelFareModel.fromJson(table48[0]);
                          print("fjhg" + m48.totalFare);
                        } else {
                          print('The list is empty.');
                        }

                        Table47InvoiceHotelListModel m47 =
                            Table47InvoiceHotelListModel.fromJson(table47[0]);
                        if (table47.isNotEmpty) {
                          m47 =
                              Table47InvoiceHotelListModel.fromJson(table47[0]);
                          print("fjhg" + m47.cancellationPolicy);
                        } else {
                          print('The list is empty.');
                        }

                        OInvoiceListHoteltaxModel m49 =
                            OInvoiceListHoteltaxModel.fromJson(table49[0]);
                        if (table49.isNotEmpty) {
                          m49 = OInvoiceListHoteltaxModel.fromJson(table49[0]);
                          print("fjhg" + m49.totalTax);
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
                                          Text(m11.corporateName,
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
                                            m11.addressLine1 +
                                                m11.addressLine2 +
                                                m11.addressLine3,
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
                                          Text('City:' + m11.city,
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
                                                m11.postCode +
                                                "|" +
                                                m11.phone,
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
                                            'Email: ' + m11.email,
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
                                        child: Text('   Traveller Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData9.length,
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
                                                      "${tableData9[index].passenger}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  Text(
                                                    'Type:+ ${tableData9[index].type}',
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
                                                      'PNR: ${tableData9[index].pnr}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      'Age : ${tableData9[index].age}',
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
                                                      'Phone : ${tableData9[index].tfpPhoneNo}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
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
                                        child: Text('   Hotel Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                        children: List.generate(
                                      tableData7.length,
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
                                                      'Hotel Name: ${tableData7[index].hotelName}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
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
                                                      'Room Type: ${tableData7[index].roomType}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      'Check In: ${tableData7[index].checkInDt}',
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
                                                      'Check Out: ${tableData7[index].checkOutDt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Nights:  ${tableData7[index].noOfNights}',
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
                                                Text(m9.passenger,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                                                  'Input Tax: ' + m10.inputTax,
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
                                                    'Output tax: ' +
                                                        m10.outputTax,
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
                                                    'Total Net Amount: ' +
                                                        m10.totalNett,
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
                                                Text('Totel Price: ',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15))),
                                              ],
                                            ),
                                          ),
                                        ]),
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
                                                child: Text(m9.passenger,
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
                                                  'Consultant:' +
                                                      m11.corporateName,
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
                                                  'CheckOut Date: ' +
                                                      m7.checkOutDt,
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 280,
                                            child: Text(
                                                'Room Description: ' +
                                                    m47.roomDescription,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                              'Room Promotion: ' +
                                                  m47.roomPromotion,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                              'Smoking Preference: ' +
                                                  m47.smokingPreference,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text('Amenity: ' + m47.amenity,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text('Inclusion: ' + m47.inclusion,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Text('Hotel Policy:     ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Text(
                                        m47.hotelNorms,
                                        style: TextStyle(fontSize: 12),
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
                                          Text('Cancellation Policy:     ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Text(
                                        m47.cancellationPolicy,
                                        style: TextStyle(fontSize: 12),
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
                                    )
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
