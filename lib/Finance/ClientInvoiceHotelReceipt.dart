import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/response_handler.dart';
import 'ClientInvoiceHotelModel.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'CreditNoteHolidayTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table10ClientInvopiceHotelReceiptModel.dart';
import 'Table10CreditNoteHotelreceiptModel.dart';
import 'Table11ClientInvoiceHotelModel.dart';
import 'Table11CreditNoteHotelreceiptModel.dart';
import 'Table13ClientInvoiceHotelReceiptModel.dart';
import 'Table1CreditNoteFlightReceiptModel.dart';
import 'Table20CreditNoteHolidayListModel.dart';
import 'Table22CrediutNoteHolidayReceiptModel.dart';
import 'Table23CreditNoteHolidayReceiptModel.dart';
import 'Table25HolidayModel.dart';
import 'Table2CreditNoteFlightreceiptModel.dart';
import 'Table48ClientInvoicetotalFareHotelModel.dart';
import 'Table48CreditNoteHolidayModel.dart';
import 'Table50CreditMoteFlightReceiptModel.dart';
import 'Table5CreditNoteFlightReceiptModel.dart';
import 'Table6CreditNoteFlightReceiptModel.dart';
import 'Table7ClientInvoiceHotelReceiptModel.dart';
import 'Table7CreditNotelHotelReceiptModel.dart';
import 'Table9ClientInvoiceHoiytelReceiptModel.dart';
import 'Table9CreditNoteHoteleceipt.dart';

class ClientInvoiceHotelReceipt extends StatefulWidget {
  final String Id;

  ClientInvoiceHotelReceipt({required this.Id});
  @override
  State<ClientInvoiceHotelReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceHotelReceipt> {
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

  List<Table7ClientInvoiceHotelReceiptModel> tableData7 = [];
  List<Table9ClientInvoiceHoiytelReceiptModel> tableData9 = [];
  List<Table10ClientInvopiceHotelReceiptModel> tableData10 = [];
  List<Table23CreditNoteHolidayReceiptModel> tableData23 = [];
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
      table7 = map["Table7"];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table22 = map["Table22"];
      table20 = map["Table20"];
      table23 = map['Table23'];
      table25 = map['Table25'];
      table13 = map["Table13"];
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
                "Client Invoice Receipt",
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
                        tableData9.clear();
                        Table9ClientInvoiceHoiytelReceiptModel m9 =
                            Table9ClientInvoiceHoiytelReceiptModel.fromJson(
                                table9[0]);
                        if (table9.isNotEmpty) {
                          for (int i = 0; i < table9.length; i++) {
                            Table9ClientInvoiceHoiytelReceiptModel t1Data =
                                Table9ClientInvoiceHoiytelReceiptModel.fromJson(
                                    table9[i]);
                            tableData9.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table20.length}, t1Data: $t1Data');
                          }
                        }
                        tableData7.clear();
                        Table7ClientInvoiceHotelReceiptModel m7 =
                            Table7ClientInvoiceHotelReceiptModel.fromJson(
                                table7[0]);
                        if (table7.isNotEmpty) {
                          for (int i = 0; i < table7.length; i++) {
                            Table7ClientInvoiceHotelReceiptModel t1Data =
                                Table7ClientInvoiceHotelReceiptModel.fromJson(
                                    table7[i]);
                            tableData7.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table22.length}, t1Data: $t1Data');
                          }
                        }

                        tableData10.clear();
                        Table10ClientInvopiceHotelReceiptModel m10 =
                            Table10ClientInvopiceHotelReceiptModel.fromJson(
                                table10[0]);
                        if (table10.isNotEmpty) {
                          for (int i = 0; i < table10.length; i++) {
                            Table10ClientInvopiceHotelReceiptModel t1Data =
                                Table10ClientInvopiceHotelReceiptModel.fromJson(
                                    table10[i]);
                            tableData10.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table22.length}, t1Data: $t1Data');
                          }
                        }
                        tableData23.clear();
                        Table23CreditNoteHolidayReceiptModel m23 =
                            Table23CreditNoteHolidayReceiptModel.fromJson(
                                table23[0]);
                        if (table23.isNotEmpty) {
                          for (int i = 0; i < table23.length; i++) {
                            Table23CreditNoteHolidayReceiptModel t1Data =
                                Table23CreditNoteHolidayReceiptModel.fromJson(
                                    table23[i]);
                            tableData23.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table23.length}, t1Data: $t1Data');
                          }
                        }

                        Table0CreditNoteFlightModsel m0 =
                            Table0CreditNoteFlightModsel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0CreditNoteFlightModsel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }

                        Table13ClientInvoiceHotelReceiptModel m13 =
                            Table13ClientInvoiceHotelReceiptModel.fromJson(
                                table13[0]);
                        if (table13.isNotEmpty) {
                          m13 = Table13ClientInvoiceHotelReceiptModel.fromJson(
                              table13[0]);
                          print("fjhg" + m13.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }

                        Table11ClientInvoiceHotelModel m11 =
                            Table11ClientInvoiceHotelModel.fromJson(table11[0]);
                        if (table11.isNotEmpty) {
                          m11 = Table11ClientInvoiceHotelModel.fromJson(
                              table11[0]);
                          print("fjhg" + m11.email);
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

                        Table48ClientInvoicetotalFareHotelModel m48 =
                            Table48ClientInvoicetotalFareHotelModel.fromJson(
                                table48[0]);
                        if (table48.isNotEmpty) {
                          m48 =
                              Table48ClientInvoicetotalFareHotelModel.fromJson(
                                  table48[0]);
                          print("fjhg" + m48.totalFare);
                        } else {
                          print('The list is empty.');
                        }

                        ClientInvoiceHotelModel m49 =
                            ClientInvoiceHotelModel.fromJson(table49[0]);
                        if (table49.isNotEmpty) {
                          m49 = ClientInvoiceHotelModel.fromJson(table49[0]);
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
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 15, top: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          m11.corporateName,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 280,
                                          child: Text(
                                            m11.addressLine1 +
                                                "," +
                                                m11.addressLine2 +
                                                "," +
                                                m11.addressLine3,
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
                                        Text('City: ' + m11.city,
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
                                          'Invoice Date: ' + m13.bookedOnDt,
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
                                          'Invoice Number: ' + m13.bookFlightId,
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
                                              m13.confirmStatus,
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
                                                  'Type: ${tableData9[index].type}',
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
                                                    'Age: ${tableData9[index].age}',
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
                                                    'Phone: ${tableData9[index].tfpPhoneNo}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15))),
                                                Text(
                                                  'PNR: ${tableData9[index].pnr}',
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
                                      child: Text('   Hotel details:',
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
                                                              FontWeight.bold)),
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
                                                      'Check In: ${tableData7[index].checkInDt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Nights: ${tableData7[index].noOfNights}',
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
                                                      'Check Out: ${tableData7[index].checkOutDt}',
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
                                      tableData10.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 15, top: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Input Tax:	${tableData10[index].inputTax}',
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
                                                    'Output tax: 	${tableData10[index].outputTax}',
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
                                                    'Total Net Amount: 	${tableData10[index].totalNett}',
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
                                                    'Total Price: ${tableData10[index].totalSales}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15))),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 10, bottom: 5),
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
                                      padding: const EdgeInsets.only(right: 4),
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
                                      padding: const EdgeInsets.only(right: 4),
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
                                      padding: const EdgeInsets.only(right: 4),
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
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
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
                                  children: tableData25.isEmpty
                                      ? [
                                          // Display "No data" text when the list is empty
                                          Text(
                                            'No data',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]
                                      : List.generate(
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
                                                      'Status: ${tableData25[index].status}',
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
                                            ],
                                          ),
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
                                  padding:
                                      const EdgeInsets.only(right: 3, left: 3),
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
