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
import 'Table13CarReceipt.dart';
import 'Table14CarRecept.dart';
import 'Table15CarReceipt.dart';
import 'Table1FLightModel.dart';
import 'Table2FlightModel.dart';
import 'Table3FareBreakDoenFlightModel.dart';
import 'Table47HotelDetailsModel.dart';
import 'Table7HotelReceiptModel.dart';
import 'VoucherHotelReceiptModel.dart';

class VouchersCarReceipt extends StatefulWidget {
  final String Id;

  VouchersCarReceipt({required this.Id});
  @override
  State<VouchersCarReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersCarReceipt> {
  late List<dynamic> table0,
      table7,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table15,
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
      table13 = map["Table13"];
      table15 = map['Table15'];
      table14 = map['Table14'];
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

                        Table13CarReceipt m13 =
                            Table13CarReceipt.fromJson(table13[0]);
                        if (table13.isNotEmpty) {
                          m13 = Table13CarReceipt.fromJson(table13[0]);
                          print("fjhg" + m13.passenger);
                        } else {
                          print('The list is empty.');
                        }
                        Table14CarRecept m14 =
                            Table14CarRecept.fromJson(table14[0]);
                        if (table14.isNotEmpty) {
                          m14 = Table14CarRecept.fromJson(table14[0]);
                          print("fjhg" + m14.CarStatus);
                        } else {
                          print('The list is empty.');
                        }

                        Table15CarReceipt m15 =
                            Table15CarReceipt.fromJson(table15[0]);
                        if (table15.isNotEmpty) {
                          m15 = Table15CarReceipt.fromJson(table15[0]);
                          print("fjhg" + m15.passenger);
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
                                            Text("Dear " + m13.passenger,
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

                                            Text("Reference number: " + m15.pnr,
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
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(m15.passenger,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            "Type:" + m15.type,
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
                                          Text(m15.pnr,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15))),
                                          Text(m15.age,
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
                                          Text('Phone:  ' + m15.tfpPhoneNo,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15))),
                                        ],
                                      ),
                                    ),
                                  ]),
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
                                      child: Text('    Car Information:',
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
                                                    'Car Company:' +
                                                        m14.CarGroup,
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
                                                    'Car Type: ' + m14.Cartype,
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
                                              Text(
                                                  'PickUp:' + m14.PickupAddress,
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
                                                  'Pickup Date:' +
                                                      m14.PickupDate,
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
                                                  'Drop Off: ' +
                                                      m14.DropoffAddress,
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
                                                  'Drop Off Date:' +
                                                      m14.DropoffDate,
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
                                      child: Text("   Payment Information",
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
                                          padding:
                                              const EdgeInsets.only(left: 0),
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
