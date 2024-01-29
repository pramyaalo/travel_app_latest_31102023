import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/response_handler.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'CreditNoteHolidayTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table1CreditNoteFlightReceiptModel.dart';
import 'Table20ClientInvoiceHolidayReceiptModel.dart';
import 'Table20CreditNoteHolidayListModel.dart';
import 'Table22ClientInvoiceHolidayReceiptModel.dart';
import 'Table22CrediutNoteHolidayReceiptModel.dart';
import 'Table23ClientInvoiceHlolidayReceiptModel.dart';
import 'Table23CreditNoteHolidayReceiptModel.dart';
import 'Table24ClientInvoiceHolidayReceiptodel.dart';
import 'Table25HolidayModel.dart';
import 'Table2CreditNoteFlightreceiptModel.dart';
import 'Table48ClientInvoiceHolidayModel.dart';
import 'Table48CreditNoteHolidayModel.dart';
import 'Table49ClientInvoiceHolidayaxModel.dart';
import 'Table50CreditMoteFlightReceiptModel.dart';
import 'Table5CreditNoteFlightReceiptModel.dart';
import 'Table6CreditNoteFlightReceiptModel.dart';

class ClientInvoiceHolidayReceipt extends StatefulWidget {
  final String Id;

  ClientInvoiceHolidayReceipt({required this.Id});
  @override
  State<ClientInvoiceHolidayReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState
    extends State<ClientInvoiceHolidayReceipt> {
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
      table25,
      table39,
      table50,
      table47,
      table48,
      table49,
      table20,
      table21;

  List<Table22ClientInvoiceHolidayReceiptModel> tableData22 = [];
  List<Table20ClientInvoiceHolidayReceiptModel> tableData20 = [];
  List<Table23ClientInvoiceHlolidayReceiptModel> tableData23 = [];
  List<Table25HolidayModel> tableData25 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ClientInvoiceViewGet", "BookFlightId=${widget.Id}");
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
      table22 = map["Table22"];
      table20 = map["Table20"];
      table23 = map['Table23'];
      table25 = map['Table25'];
      table24 = map["Table24"];
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
             backgroundColor: Colors.white
            ),
            body: Center(
              child: FutureBuilder<String?>(
                  future: getLabels(),
                  builder: (context, snapshot) {
                    print('object' + snapshot.connectionState.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      try {
                        tableData20.clear();
                        Table20ClientInvoiceHolidayReceiptModel m20 =
                            Table20ClientInvoiceHolidayReceiptModel.fromJson(
                                table20[0]);
                        if (table20.isNotEmpty) {
                          for (int i = 0; i < table20.length; i++) {
                            Table20ClientInvoiceHolidayReceiptModel t1Data =
                                Table20ClientInvoiceHolidayReceiptModel
                                    .fromJson(table20[i]);
                            tableData20.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table20.length}, t1Data: $t1Data');
                          }
                        }
                        tableData22.clear();
                        Table22ClientInvoiceHolidayReceiptModel m22 =
                            Table22ClientInvoiceHolidayReceiptModel.fromJson(
                                table22[0]);
                        if (table22.isNotEmpty) {
                          for (int i = 0; i < table22.length; i++) {
                            Table22ClientInvoiceHolidayReceiptModel t1Data =
                                Table22ClientInvoiceHolidayReceiptModel
                                    .fromJson(table22[i]);
                            tableData22.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table22.length}, t1Data: $t1Data');
                          }
                        }
                        tableData23.clear();
                        Table23ClientInvoiceHlolidayReceiptModel m23 =
                            Table23ClientInvoiceHlolidayReceiptModel.fromJson(
                                table23[0]);
                        if (table23.isNotEmpty) {
                          for (int i = 0; i < table23.length; i++) {
                            Table23ClientInvoiceHlolidayReceiptModel t1Data =
                                Table23ClientInvoiceHlolidayReceiptModel
                                    .fromJson(table23[i]);
                            tableData23.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table23.length}, t1Data: $t1Data');
                          }
                        }

                        tableData25.clear();
                        Table25HolidayModel m25 =
                            Table25HolidayModel.fromJson(table25[0]);
                        if (table25.isNotEmpty) {
                          for (int i = 0; i < table25.length; i++) {
                            Table25HolidayModel t1Data =
                                Table25HolidayModel.fromJson(table25[i]);
                            tableData25.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table25.length}, t1Data: $t1Data');
                          }
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

                        /*  tableData50.clear();
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
                        }*/
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

                        Table48ClientInvoiceHolidayModel m48 =
                            Table48ClientInvoiceHolidayModel.fromJson(
                                table48[0]);
                        if (table48.isNotEmpty) {
                          m48 = Table48ClientInvoiceHolidayModel.fromJson(
                              table48[0]);
                          print("fjhg" + m48.totalFare);
                        } else {
                          print('The list is empty.');
                        }

                        Table49ClientInvoiceHolidayaxModel m49 =
                            Table49ClientInvoiceHolidayaxModel.fromJson(
                                table49[0]);
                        if (table49.isNotEmpty) {
                          m49 = Table49ClientInvoiceHolidayaxModel.fromJson(
                              table49[0]);
                          print("fjhg" + m49.totalTax);
                        } else {
                          print('The list is empty.');
                        }

                        Table24ClientInvoiceHolidayReceiptodel m24 =
                            Table24ClientInvoiceHolidayReceiptodel.fromJson(
                                table24[0]);
                        if (table24.isNotEmpty) {
                          m24 = Table24ClientInvoiceHolidayReceiptodel.fromJson(
                              table24[0]);
                          print("fjhg" + m24.phone);
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
                                      Text('Client Invoice',
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
                                    child: Text('Client Invoice',
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
                                          Container(
                                            width: 290,
                                            child: Text(
                                              m5.addressLine1 +
                                                  m5.addressLine2 +
                                                  m5.addressLine3,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text('City: ' + m5.city,
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
                                            'Invoice Date: ' + m0.bookedOnDt,
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
                                      children: (tableData22.contains(0) ||
                                              tableData22.isEmpty)
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
                                              tableData22.length,
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
                                                          "${tableData22[index].passenger}",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          'Type: ${tableData22[index].type}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          'PNR : ${tableData22[index].pnr}',
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
                                                          'Phone: ${tableData22[index].phoneNo}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          'Age: ${tableData22[index].age}',
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
                                                      children: [],
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
                                        child: Text('   Holiday Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData20.length,
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
                                                        'Hotel Name: ${tableData20[index].hotelName}',
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
                                                        'Bar Code: ${tableData20[index].barcodeData}',
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
                                                        'Product Code: ${tableData20[index].roomType}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                      'Days: ${tableData20[index].noOfNights}',
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
                                                        'Start Date: ${tableData20[index].checkInDt}',
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
                                                        'End Date: ${tableData20[index].checkOutDt}',
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
                                        child: Text('   Payment Details:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData23.length,
                                        (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
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
                                                      'Input Tax:	${tableData23[index].inputTax}',
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
                                                        'Output tax: 	${tableData23[index].outputTax}',
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
                                                        'Total Net Amount: 	${tableData23[index].totalNett}',
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
                                                        'Total Price: ${tableData23[index].totalSales}',
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
                                                child: Text(m22.passenger,
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
                                                  '	CheckOut Date:' +
                                                      m20.checkOutDt,
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
                                                  'Consultant: ' +
                                                      m24.corporateName,
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
                                        child: Text(' Received Payments:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData25.length,
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
                                                      'Receipt No: ${tableData25[index].receiptNo}',
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
                                                      'Allocated Amount: ${tableData25[index].allocatedAmount}',
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
                                                      'Status:${tableData25[index].status}',
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
                                                      'Date: ${tableData25[index].createdDate}',
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
