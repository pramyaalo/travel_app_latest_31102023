import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'Flight_VouchersListModel.dart';
import 'Table0HotelBookingModel.dart';
import 'Table10hotelReceiptModel.dart';
import 'Table1FLightModel.dart';
import 'Table2FlightModel.dart';
import 'Table3FareBreakDoenFlightModel.dart';
import 'Table47HotelDetailsModel.dart';
import 'Table7HotelReceiptModel.dart';
import 'VoucherHotelReceiptModel.dart';

class VouchersHotelReceipt extends StatefulWidget {
  final String Id;

  VouchersHotelReceipt({required this.Id});
  @override
  State<VouchersHotelReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersHotelReceipt> {
  late List<dynamic> table0,
      table7,
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
      table47,
      table48,
      table49;
  List<Table0HotelBookingModel> tableData0 = [];
  List<VoucherHotelReceiptModel> tableData9 = [];
  List<Table7HotelReceiptModel> tableData1 = [];
  List<Table47HotelDetailsModel> tableData2 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "VoucherViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      developer.log('jfghhjghId ' + jsonResponse,
          name: 'travel_app_17112023_b2b');
      Map<String, dynamic> map = json.decode(jsonResponse);

      table7 = map['Table7'];
      table9 = map["Table9"];
      table0 = map['Table'];

      table10 = map["Table10"];
      table48 = map["Table48"];
      table49 = map['Table49'];
      /*  table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];*/
      table47 = map['Table47'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Vouchers Receipt",
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
                        Table0HotelBookingModel m0 =
                            Table0HotelBookingModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0HotelBookingModel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }

                        tableData9.clear();
                        VoucherHotelReceiptModel m9 =
                            VoucherHotelReceiptModel.fromJson(table9[0]);
                        if (table9.isNotEmpty) {
                          for (int i = 0; i < table9.length; i++) {
                            VoucherHotelReceiptModel t1Data =
                                VoucherHotelReceiptModel.fromJson(table9[i]);
                            tableData9.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table9.length}, t1Data: $t1Data');
                          }
                        }

                        Table7HotelReceiptModel m7 =
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
                        }

                        return SingleChildScrollView(
                            child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                margin: EdgeInsets.all(10),
                                child: Column(children: [
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
                                        Image.asset(
                                            'assets/images/logolatest.png',
                                            width: 150,
                                            height: 50),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            Text("Dear " + m9.passenger,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15)),
                                            // Your date widget goes here
                                            Text(
                                                "Thank you for booking with Travel Demo.Our preferred partner would like to invite you to join a paid subscription service for access to discount offers.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15)),
                                            SizedBox(
                                              height: 4,
                                            ),

                                            Text("Reference number: " + m9.pnr,
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
                                                "Booking Status: " +
                                                    m0.bookingStatus,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color: Colors.black26,
                                      alignment: Alignment.centerLeft,
                                      child: Text('   Traveller Information',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                    ),
                                  ),
                                  Column(
                                      children: List.generate(
                                          tableData9.length,
                                          (index) => Column(children: [
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
                                                          "${tableData9[index].passenger}",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      Text(
                                                        "${tableData9[index].type}",
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15)),
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
                                                          "${tableData9[index].pnr}",
                                                          style: (TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15))),
                                                      Text(
                                                          "${tableData9[index].age}",
                                                          style: (TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15))),
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
                                                          'Phone:  ' +
                                                              "${tableData9[index].tfpPhoneNo}",
                                                          style: (TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15))),
                                                    ],
                                                  ),
                                                ),
                                              ]))),
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
                                      child: Text('Hotel Information:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 280,
                                                child: Text(
                                                    'Name: ' + m7.hotelName,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
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
                                                    'Room Type: ' +
                                                        m7.hotelAddress,
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15))),
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
                                              Text('Check In: ' + m7.checkInDt,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Check Out: ' + m7.checkOutDt,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Nights: ' + m7.noofNights,
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
                                              fontWeight: FontWeight.w600)),
                                      Text('       :    	',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
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
                                      Text('NET PAYABLE  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18)),
                                      Text('    :    	',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
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
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: 280,
                                          child: Text(
                                            '* Preferences and special requests cannot be guaranteed. Special requests are subject to availability upon check-in and may incur additional charges.',
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
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: 280,
                                          child: Text(
                                            '* Baggage disconts may apply based on frequent flyer status/online checkIn/from of payment/military/etc.',
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
                                                  fontWeight: FontWeight.w600)),
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
                                ])));
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
