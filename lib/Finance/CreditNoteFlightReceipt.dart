import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/response_handler.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table1CreditNoteFlightReceiptModel.dart';
import 'Table2CreditNoteFlightreceiptModel.dart';
import 'Table50CreditMoteFlightReceiptModel.dart';
import 'Table5CreditNoteFlightReceiptModel.dart';
import 'Table6CreditNoteFlightReceiptModel.dart';

class CreditNoteFlightReceipt extends StatefulWidget {
  final String Id;

  CreditNoteFlightReceipt({required this.Id});
  @override
  State<CreditNoteFlightReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditNoteFlightReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
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

  List<Table2CreditNoteFlightreceiptModel> tableData2 = [];
  List<Table1CreditNoteFlightReceiptModel> tableData1 = [];
  List<Table6CreditNoteFlightReceiptModel> tableData6 = [];
  List<Table50CreditMoteFlightReceiptModel> tableData50 = [];

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
      table5 = map['Table5'];
      table6 = map['Table6'];
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
                "CreditNote Receipt",
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
                        tableData1.clear();
                        Table1CreditNoteFlightReceiptModel m1 =
                            Table1CreditNoteFlightReceiptModel.fromJson(
                                table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            Table1CreditNoteFlightReceiptModel t1Data =
                                Table1CreditNoteFlightReceiptModel.fromJson(
                                    table1[i]);
                            tableData1.add(t1Data);
                            print(
                                'Index: $i, Table4 bfgLength: ${table1.length}, t1Data: $t1Data');
                          }
                        }
                        tableData6.clear();
                        Table6CreditNoteFlightReceiptModel m6 =
                            Table6CreditNoteFlightReceiptModel.fromJson(
                                table6[0]);
                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6CreditNoteFlightReceiptModel t1Data =
                                Table6CreditNoteFlightReceiptModel.fromJson(
                                    table6[i]);
                            tableData6.add(t1Data);
                            print(
                                'Index: $i, Table4deftt Length: ${table6.length}, t1Data: $t1Data');
                          }
                        }
                        tableData2.clear();
                        Table2CreditNoteFlightreceiptModel m2 =
                            Table2CreditNoteFlightreceiptModel.fromJson(
                                table2[0]);

                        if (table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            Table2CreditNoteFlightreceiptModel t1Data =
                                Table2CreditNoteFlightreceiptModel.fromJson(
                                    table2[i]);
                            tableData2.add(t1Data);
                          }
                          print(' Table4 yuLength: ${table2.length}');
                        }

                        //Table6CreditNoteFlightReceiptModel

                        Table0CreditNoteFlightModsel m0 =
                            Table0CreditNoteFlightModsel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0CreditNoteFlightModsel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }
                        Table5CreditNoteFlightReceiptModel m5 =
                            Table5CreditNoteFlightReceiptModel.fromJson(
                                table5[0]);
                        if (table5.isNotEmpty) {
                          m5 = Table5CreditNoteFlightReceiptModel.fromJson(
                              table5[0]);
                          print("fjhg" + m5.corporateName);
                        } else {
                          print('The list is empty.');
                        }
                        //Table5CreditNoteFlightReceiptModel

                        tableData50.clear();
                        Table50CreditMoteFlightReceiptModel m50 =
                            Table50CreditMoteFlightReceiptModel.fromJson(
                                table50[0]);
                        if (table50.isNotEmpty) {
                          for (int i = 0; i < table50.length; i++) {
                            Table50CreditMoteFlightReceiptModel t1Data =
                                Table50CreditMoteFlightReceiptModel.fromJson(
                                    table50[i]);
                            tableData50.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table50.length}, t1Data: $t1Data');
                          }
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

                        tableData6.clear();
                        Table6CreditNoteFlightReceiptModel m10 =
                            Table6CreditNoteFlightReceiptModel.fromJson(
                                table6[0]);
                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6CreditNoteFlightReceiptModel t1Data =
                                Table6CreditNoteFlightReceiptModel.fromJson(
                                    table6[i]);
                            tableData6.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table6.length}, t1Data: $t1Data');
                          }
                        }
                        Tabe48CreditNoteFareModel m48 =
                            Tabe48CreditNoteFareModel.fromJson(table48[0]);
                        if (table48.isNotEmpty) {
                          m48 = Tabe48CreditNoteFareModel.fromJson(table48[0]);
                          print("fjhg" + m48.totalFare);
                        } else {
                          print('The list is empty.');
                        }

                        CreditNoteFlightTaxModel m49 =
                            CreditNoteFlightTaxModel.fromJson(table49[0]);
                        if (table49.isNotEmpty) {
                          m49 = CreditNoteFlightTaxModel.fromJson(table49[0]);
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
                                      Text('Credit Note',
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
                                    child: Text('Credit Note',
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
                                          Text(m2.passenger,
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
                                            'Email: ' + m2.custEmail,
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
                                          Text('Phone: ' + m2.custPhone,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            m5.corporateName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
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
                                            'PinCode: ' + m5.postCode,
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
                                            'Phone: ' + m5.phone,
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
                                      children: (tableData2.contains(0) ||
                                              tableData2.isEmpty)
                                          ? [
                                              // Display "No data" text when the list is null or empty
                                              Text(
                                                'No data',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]
                                          : List.generate(
                                              tableData2.length,
                                              (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 15,
                                                            top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${tableData2[index].passenger}",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          'Type: ${tableData2[index].type}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 15,
                                                            top: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Passenger ID: ${tableData2[index].passengerID}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          'Age: ${tableData2[index].age}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 15,
                                                            top: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Phone: ${tableData2[index].tfpPhoneNo}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          'Ticket No: ${tableData2[index].ticketNo}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
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
                                                        '${tableData1[index].tfsDepAirport}' +
                                                            '-' +
                                                            '${tableData1[index].tfsArrAirport}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
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
                                                        '	Depart Date: ${tableData1[index].tfsDepDatedt}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        '	Flight No: ${tableData1[index].tfsFlightNumber}',
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
                                                        '	Arrival Date: ${tableData1[index].tfsArrDatedt}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                      '	Duration: ${tableData1[index].tfsDuration}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
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
                                                      'Input Tax:	${tableData50[index].inputTax}',
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
                                                        'Output tax: 	${tableData50[index].outputTax}',
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
                                                        'Total Net Amount: 	${tableData50[index].totalNett}',
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
                                                        'Total Price: ${tableData50[index].totalSales}',
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
                                          right: 3,
                                          left: 3,
                                          top: 10,
                                          bottom: 5),
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Total Fare',
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
                                        Text('Net Amount ',
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
                                        child: Text(
                                            ' Payment Credited Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData6.length,
                                        (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 4),
                                                    child: Text(
                                                      'Receipt No: ${tableData6[index].receiptNo}',
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 3),
                                                    child: Text(
                                                      'Allocated Amount: ${tableData6[index].allocatedAmount}',
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    child: Text(
                                                      'Status:${tableData6[index].status}',
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    child: Text(
                                                      'Date: ${tableData6[index].createdDate}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
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
