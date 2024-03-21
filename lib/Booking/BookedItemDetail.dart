import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Finance/InvoiceFlightListReceipt.dart';
import '../Finance/InvoiceHotelReceipt.dart';
import '../Finance/VouchersFlightReceipt.dart';
import '../Finance/VouchersHotelReceipt.dart';
import '../Models/BusTermsandConditionsModels.dart';
import '../Models/CarBreakDownModel.dart';
import '../Models/HolidayFareBreakdownModel.dart';
import '../Models/HolidayPassengerModel.dart';
import '../Models/HotelFareBreakDownModel.dart';
import '../Models/HotelPassengerModel.dart';
import '../Receipt/FlightInvoice.dart';
import '../Receipt/InvoiceReceipt.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'BusBookingModel.dart';
import 'BusFareBreakDown.dart';
import 'BusPassengerModel.dart';
import 'CarBookingModel.dart';
import 'CarPassengerModel.dart';
import 'FareBreakDownModel.dart';
import 'FlightSegment.dart';
import 'HolidayBookingModel.dart';
import 'HotelBookingModel.dart';
import 'HotelRoomDetailsModel.dart';
import 'PassengerModel.dart';

class BookedItemDetail extends StatefulWidget {
  final id;
  BookedItemDetail({super.key, required this.id});

  @override
  State<BookedItemDetail> createState() => _BookedItemDetailState();
}

class _BookedItemDetailState extends State<BookedItemDetail> {
  String selectedAccountType = 'Select Document';

  var accountTypes = ['Select Document'];
  String selectedDocument = 'Select Document';
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table39,
      table40,
      table21;
  List<BookedItemViewModel> tableData = [];
  List<FlightSegment> table1Data = [];

  List<PassengerModel> table2Data = [];
  List<FareBreakdownModel> table3Data = [];
  List<HotelBooking> table6Data = [];
  List<HotelFareBreakDownModel> table9Data = [];
  List<HotelPassengerModel> table8Data = [];
  List<CarBookingModel> table12Data = [];
  List<CarPassengerModel> table13Data = [];
  List<CarBreakDownModel> table14Data = [];
  List<HolidayBookingModel> table16Data = [];
  List<HolidayPassengerModel> table18Data = [];
  List<HolidayFareBreakdownModel> table19Data = [];
  List<BusBookingModel> table22Data = [];
  List<BusPassengerModel> table23Data = [];
  List<BusFareBreakDown> table24Data = [];
  List<BusTermsandConditionsModels> table39Data = [];
  List<HotelRoomDetailsModel> table40Data = [];
  static String savedId = '';
  String? savedName;
  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedId = prefs.getString('userId')!;
    });
  }

  Future<String?> getLabels() async {
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", 'BookFlightId=${widget.id}&StaffId=0');
    print('abi' + widget.id.toString());
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];
      table9 = map["Table9"];
      table8 = map['Table8'];
      table12 = map['Table12'];
      table13 = map['Table13'];
      table14 = map['Table14'];
      table16 = map['Table16'];
      table18 = map['Table18'];
      table19 = map['Table19'];
      table22 = map['Table22'];
      table23 = map['Table23'];
      table24 = map['Table24'];
      table39 = map['Table39'];
      table40 = map['Table40'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  tableData.clear();
                  if (table0.isNotEmpty) {
                    BookedItemViewModel m0 =
                        BookedItemViewModel.fromJson(table0[0]);
                    for (int i = 0; i < table0.length; i++) {
                      BookedItemViewModel t1Data =
                          BookedItemViewModel.fromJson(table0[i]);
                      tableData.add(t1Data);
                      print(
                          'Index: $i, Table4 Length: ${table0.length}, t1Data: $t1Data');
                    }
                  }

                  table1Data.clear();
                  if (table1.isNotEmpty) {
                    FlightSegment m1 = FlightSegment.fromJson(table1[0]);
                    for (int i = 0; i < table1.length; i++) {
                      FlightSegment t1Data = FlightSegment.fromJson(table1[i]);
                      table1Data.add(t1Data);
                      print(
                          'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                    }
                  }

                  table2Data.clear();
                  if (table2.isNotEmpty) {
                    PassengerModel m2 = PassengerModel.fromJson(table2[0]);
                    for (int i = 0; i < table2.length; i++) {
                      PassengerModel t2Data =
                          PassengerModel.fromJson(table2[i]);
                      table2Data.add(t2Data);
                      print(
                          'Index: $i, Table4 Length: ${table2.length}, t1Data: $t2Data');
                    }
                  }

                  table3Data.clear();
                  if (table3.isNotEmpty) {
                    FareBreakdownModel m3 =
                        FareBreakdownModel.fromJson(table3[0]);
                    for (int i = 0; i < table3.length; i++) {
                      FareBreakdownModel t3Data =
                          FareBreakdownModel.fromJson(table3[i]);
                      table3Data.add(t3Data);
                      print(
                          'Index: $i, Table4 Length: ${table3.length}, t1Data: $t3Data');
                    }
                  }

                  table6Data.clear();
                  if (table6.isNotEmpty) {
                    HotelBooking m6 = HotelBooking.fromJson(table6[0]);

                    for (int i = 0; i < table6.length; i++) {
                      HotelBooking t6Data = HotelBooking.fromJson(table6[i]);
                      table6Data.add(t6Data);
                      print(
                          'Index: $i, Table6 Length: ${table6.length}, t1Data: $t6Data');
                    }
                  }
                  table8Data.clear();
                  if (table8.isNotEmpty) {
                    HotelPassengerModel m8 =
                        HotelPassengerModel.fromJson(table8[0]);

                    for (int i = 0; i < table8.length; i++) {
                      HotelPassengerModel t8Data =
                          HotelPassengerModel.fromJson(table8[i]);
                      table8Data.add(t8Data);
                      print(
                          'Index: $i, Table8 Length: ${table8.length}, t1Data: $t8Data');
                    }
                  }
                  table9Data.clear();
                  if (table9.isNotEmpty) {
                    HotelFareBreakDownModel m9 =
                        HotelFareBreakDownModel.fromJson(table9[0]);

                    for (int i = 0; i < table9.length; i++) {
                      HotelFareBreakDownModel t9Data =
                          HotelFareBreakDownModel.fromJson(table9[i]);
                      table9Data.add(t9Data);
                      print(
                          'Index: $i, Table6 Length: ${table9.length}, t1Data: $t9Data');
                    }
                  }

                  table12Data.clear();
                  if (table12.isNotEmpty) {
                    CarBookingModel m16 = CarBookingModel.fromJson(table12[0]);

                    for (int i = 0; i < table12.length; i++) {
                      CarBookingModel t16Data =
                          CarBookingModel.fromJson(table12[i]);
                      table12Data.add(t16Data);
                      print(
                          'Index: $i, Table12 Length: ${table12.length}, t1Data: $t16Data');
                    }
                  }

                  table13Data.clear();
                  if (table13.isNotEmpty) {
                    CarPassengerModel m16 =
                        CarPassengerModel.fromJson(table13[0]);

                    for (int i = 0; i < table13.length; i++) {
                      CarPassengerModel t13Data =
                          CarPassengerModel.fromJson(table13[i]);
                      table13Data.add(t13Data);
                      print(
                          'Index: $i, Table12 Length: ${table13.length}, t1Data: $t13Data');
                    }
                  }
                  table14Data.clear();
                  if (table14.isNotEmpty) {
                    CarBreakDownModel m14 =
                        CarBreakDownModel.fromJson(table14[0]);

                    for (int i = 0; i < table14.length; i++) {
                      CarBreakDownModel t16Data =
                          CarBreakDownModel.fromJson(table14[i]);
                      table14Data.add(t16Data);
                      print(
                          'Index: $i, Table16 Length: ${table14.length}, t1Data: $t16Data');
                    }
                  }

                  table16Data.clear();
                  if (table16.isNotEmpty) {
                    HolidayBookingModel m16 =
                        HolidayBookingModel.fromJson(table16[0]);

                    for (int i = 0; i < table16.length; i++) {
                      HolidayBookingModel t16Data =
                          HolidayBookingModel.fromJson(table16[i]);
                      table16Data.add(t16Data);
                      print(
                          'Index: $i, Table16 Length: ${table16.length}, t1Data: $t16Data');
                    }
                  }

                  table18Data.clear();
                  if (table18.isNotEmpty) {
                    HolidayPassengerModel m16 =
                        HolidayPassengerModel.fromJson(table18[0]);

                    for (int i = 0; i < table18.length; i++) {
                      HolidayPassengerModel t18Data =
                          HolidayPassengerModel.fromJson(table18[i]);
                      table18Data.add(t18Data);
                      print(
                          'Index: $i, Table16 Length: ${table18.length}, t1Data: $t18Data');
                    }
                  }
                  table19Data.clear();
                  if (table19.isNotEmpty) {
                    HolidayFareBreakdownModel m16 =
                        HolidayFareBreakdownModel.fromJson(table19[0]);

                    for (int i = 0; i < table19.length; i++) {
                      HolidayFareBreakdownModel t19Data =
                          HolidayFareBreakdownModel.fromJson(table19[i]);
                      table19Data.add(t19Data);
                      print(
                          'Index: $i, Table16 Length: ${table19.length}, t1Data: $t19Data');
                    }
                  }
                  table22Data.clear();
                  if (table22.isNotEmpty) {
                    BusBookingModel m16 = BusBookingModel.fromJson(table22[0]);

                    for (int i = 0; i < table22.length; i++) {
                      BusBookingModel t22Data =
                          BusBookingModel.fromJson(table22[i]);
                      table22Data.add(t22Data);
                      print(
                          'Index: $i, Table16 Length: ${table22.length}, t1Data: $t22Data');
                    }
                  }
                  table23Data.clear();
                  if (table23.isNotEmpty) {
                    BusPassengerModel m16 =
                        BusPassengerModel.fromJson(table23[0]);

                    for (int i = 0; i < table23.length; i++) {
                      BusPassengerModel t22Data =
                          BusPassengerModel.fromJson(table23[i]);
                      table23Data.add(t22Data);
                      print(
                          'Index: $i, Table16 Length: ${table23.length}, t1Data: $t22Data');
                    }
                  }
                  table24Data.clear();
                  if (table24.isNotEmpty) {
                    BusFareBreakDown m16 =
                        BusFareBreakDown.fromJson(table24[0]);

                    for (int i = 0; i < table24.length; i++) {
                      BusFareBreakDown t24Data =
                          BusFareBreakDown.fromJson(table24[i]);
                      table24Data.add(t24Data);
                      print(
                          'Index: $i, Table16 Length: ${table24.length}, t1Data: $t24Data');
                    }
                  }
                  table39Data.clear();
                  if (table39.isNotEmpty) {
                    BusTermsandConditionsModels m40 =
                        BusTermsandConditionsModels.fromJson(table39[0]);

                    for (int i = 0; i < table39.length; i++) {
                      BusTermsandConditionsModels t39Data =
                          BusTermsandConditionsModels.fromJson(table39[i]);
                      table39Data.add(t39Data);
                      print(
                          'Index: $i, Table6 Length: ${table39.length}, t1Data: $t39Data');
                    }
                  }
                  table40Data.clear();
                  if (table40.isNotEmpty) {
                    HotelRoomDetailsModel m40 =
                        HotelRoomDetailsModel.fromJson(table40[0]);

                    for (int i = 0; i < table40.length; i++) {
                      HotelRoomDetailsModel t40Data =
                          HotelRoomDetailsModel.fromJson(table40[i]);
                      table40Data.add(t40Data);
                      print(
                          'Index: $i, Table6 Length: ${table40.length}, t1Data: $t40Data');
                    }
                  }
                  if (tableData[0].bookingType == "Car".toString())
                    accountTypes = [
                      'Select Document',
                      'Car Invoice',
                      'Car Voucher',
                      'Car Receipt',
                      'Car Itinerary',
                    ];
                  if (tableData[0].bookingType == "Flight".toString())
                    accountTypes = [
                      'Select Document',
                      'Flight Invoice',
                      'Flight Voucher',
                      'Flight Receipt',
                    ];
                  if (tableData[0].bookingType == "Hotel".toString())
                    accountTypes = [
                      'Select Document',
                      'Hotel Invoice',
                      'Hotel Voucher',
                      'Hotel Receipt',
                      'Hotel Itinerary',
                    ];
                  if (tableData[0].bookingType == "Holiday".toString())
                    accountTypes = [
                      'Select Document',
                      'Holiday Invoice',
                      'Holiday Voucher',
                      'Holiday Receipt',
                      'Holiday Itinerary',
                    ];
                  if (tableData[0].bookingType == "Bus".toString())
                    accountTypes = [
                      'Select Document',
                      'Bus Invoice',
                      'Bus Voucher',
                      'Bus Receipt',
                      'Bus Itinerary',
                    ];
                  /* Tableee2 m2 = Tableee2.fromJson(table2[0]);

                  Tableee3 m3 = Tableee3.fromJson(table3[0]);
                  Tableee4 m4 = Tableee4.fromJson(table4[0]);
                  table1Data.clear();
                  for (int i = 0; i < table4.length; i++) {
                    t1Data = Tableee4.fromJson(table4[i]);

                    table1Data.add(t1Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tableee5 m5 = Tableee5.fromJson(table5[0]);
                  table2Data.clear();
                  for (int i = 0; i < table5.length; i++) {
                    Tableee5 t2Data = Tableee5.fromJson(table5[i]);

                    table2Data.add(t2Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tableee6 m6 = Tableee6.fromJson(table6[0]);
                  table3Data.clear();
                  for (int i = 0; i < table6.length; i++) {
                    Tableee6 t3Data = Tableee6.fromJson(table6[i]);

                    table3Data.add(t3Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tablee7 m7 = Tablee7.fromJson(table7[0]);*/
                  return SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                            children: List.generate(
                          tableData.length,
                          (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booked Item",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: PhysicalModel(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Booking Id: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 17),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "${tableData[index].bookingId}",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Booking Type: " +
                                                                "${tableData[index].bookingType}",
                                                            // m0.bookingType,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          const SizedBox(
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10.0, 5, 10, 5),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      border: Border.all(
                                                          width: 0.1,
                                                          color: Colors.orange),
                                                      //https://stackoverflow.com/a/67395539/16076689
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Text(
                                                      "${tableData[index].bookingStatus}",

                                                      //  m0.documentStatus,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
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
                                                      const Image(
                                                        image: AssetImage(
                                                            'assets/images/tickiconpng.png'),
                                                        color: Colors.blue,
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        "${tableData[index].bookedOnDt}",

                                                        //  m0.bookedOnDt,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 0,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 225,
                                                height: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffededed)),
                                                ),
                                              ),
                                              Text(
                                                "Price(Incl. Tax)",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (tableData[0].bookingType ==
                                                    "Flight")
                                                  // If booking type is Flight, display DropdownButtonFormField
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: 170,
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Select Document',
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    bottom: 5),
                                                          ),
                                                          value:
                                                              selectedAccountType,
                                                          items: accountTypes.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                  "   " +
                                                                      value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedAccountType =
                                                                  newValue!;
                                                            });

                                                            // Check if a value is selected and navigate to the next page
                                                            if (newValue !=
                                                                    null &&
                                                                newValue
                                                                    .isNotEmpty) {
                                                              if (newValue ==
                                                                  'Flight Invoice') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            InvoiceListReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (newValue ==
                                                                  'Flight Receipt') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            InvoiceListReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (newValue ==
                                                                  'Flight Voucher') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            VouchersReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              //VouchersReceipt
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                if (tableData[0].bookingType ==
                                                    "Hotel")
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: 170,
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Select Document',
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    bottom: 5),
                                                          ),
                                                          value:
                                                              selectedAccountType,
                                                          items: accountTypes.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                  "   " +
                                                                      value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedAccountType =
                                                                  newValue!;
                                                            });

                                                            // Check if a value is selected and navigate to the next page
                                                            if (newValue !=
                                                                    null &&
                                                                newValue
                                                                    .isNotEmpty) {
                                                              if (newValue ==
                                                                  'Hotel Invoice') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            InvoiceHotelReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (newValue ==
                                                                  'Hotel Receipt') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            InvoiceHotelReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (newValue ==
                                                                  'Hotel Voucher') {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            VouchersHotelReceipt(
                                                                      Id: tableData[
                                                                              index]
                                                                          .bookFlightId,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              //VouchersReceipt
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                // If booking type is Hotel, display something else
                                                // You can add the widget for Hotel booking here

                                                Text(
                                                  "${tableData[index].bookingTotalAmount}",
                                                  //m0.bookingTotalAmount,
                                                  style: const TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (tableData[index].bookingType == "Flight")
                                  Text(
                                    tableData[index].bookingType +
                                        " " +
                                        "Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (tableData[index].bookingType == "Hotel")
                                  Text(
                                    tableData[index].bookingType +
                                        " " +
                                        "Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (tableData[index].bookingType == "Car")
                                  Text(
                                    tableData[index].bookingType +
                                        " " +
                                        "Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (tableData[index].bookingType == "Holiday")
                                  Text(
                                    tableData[index].bookingType +
                                        " " +
                                        "Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (tableData[index].bookingType == "Bus")
                                  Text(
                                    tableData[index].bookingType +
                                        " " +
                                        "Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (tableData[index].bookingType == "Flight")
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table1Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Itinerary: ' +
                                                                "${table1Data[index].tfsDepAirport + "-" + table1Data[index].tfsArrAirport}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'GDS/LCC PNR: ' +
                                                                "${table1Data[index].tfsAirlinePNR}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Flight No: ' +
                                                                "${table1Data[index].tfsFlightNumber + " " + "(" + table1Data[index].tfsAirline + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Departure Time: ' +
                                                                "${table1Data[index].tfsDepDatedt + " " + "(" + table1Data[index].tfsDepTime + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Terminal: ' +
                                                                "${table1Data[index].tfsDepTerminal}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Arrival Time: ' +
                                                                "${table1Data[index].tfsArrDatedt + " " + "(" + table1Data[index].tfsArrTime + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Terminal: ' +
                                                                "${table1Data[index].tfsArrTerminal}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'PNR: ' +
                                                                "", //m2.pnr,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Class Name: ' +
                                                                "${table1Data[index].tfsClassName}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Duration: ' +
                                                                "${table1Data[index].tfsDuration}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Hotel".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table6Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Itinerary: ' +
                                                                "${table6Data[index].noOfNights}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Hotel Name: ' +
                                                                  "${table6Data[index].hotelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'Room Type: ' +
                                                                  "${table6Data[index].roomType}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'CheckIn: ' +
                                                                "${table6Data[index].checkInDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher Number: ' +
                                                                "${table6Data[index].thhBookFlightId}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Check Out: ' +
                                                                "${table6Data[index].checkOutDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No: ' +
                                                                "${table6Data[index].confirmationNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Status: ' +
                                                                "", //m2.pnr,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Car".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table12Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Itinerary: ' +
                                                                "${table12Data[index].carGroup1}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Company : ' +
                                                                  "${table12Data[index].carName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'PickUp : ' +
                                                                  "${table12Data[index].pickupDate}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Pickup Location: ' +
                                                                "${table12Data[index].pickupLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'DropOff: ' +
                                                                "${table12Data[index].dropoffDate}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Dropoff Location: ' +
                                                                "${table12Data[index].dropoffLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Type: ' +
                                                                "${table12Data[index].carType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Group: ' +
                                                                "${table12Data[index].carGroup}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Status: ' +
                                                                "${table12Data[index].carStatus}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Luggage : ' +
                                                                "${table12Data[index].luggage}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No : ' +
                                                                "${table12Data[index].confirmationNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher No : ' +
                                                                "${table12Data[index].bookingRefNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Holiday".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table16Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Itinerary: ' +
                                                                "${table16Data[index].productId}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Holiday Name  : ' +
                                                                  "${table16Data[index].hotelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'Product ID : ' +
                                                                  "${table16Data[index].productId}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Product Code: ' +
                                                                "${table16Data[index].roomType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Start Date: ' +
                                                                "${table16Data[index].checkInDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'End Date: ' +
                                                                "${table16Data[index].checkOutDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher No: ' +
                                                                "${table16Data[index].bookFlightId}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No: ' +
                                                                "${table16Data[index].roomType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Bus".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table22Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Itinerary: ' +
                                                                "${table22Data[index].busHeadID}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Travel Name   : ' +
                                                                  "${table22Data[index].travelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'PickUp : ' +
                                                                "${table22Data[index].destinationCityDate}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Pickup Location: ' +
                                                                "${table22Data[index].destinationCityLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'DropOff: ' +
                                                                "${table22Data[index].originCityDate}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Dropoff Location: ' +
                                                                "${table22Data[index].originCityLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Bus Type: ' +
                                                                "${table22Data[index].busType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                /*Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),*/
                                Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pricing Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (tableData[index].bookingType == "Flight")
                                  Column(
                                    children: List.generate(
                                      table3Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Net Price: ' +
                                                        "${table3Data[index].totalNett}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Input Tax: ' +
                                                        "${table3Data[index].inputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Output Tax: ' +
                                                        "${table3Data[index].outputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Total Price: ' +
                                                        "${table3Data[index].totalSales}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Hotel".toString())
                                  Column(
                                    children: List.generate(
                                      table9Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Net Price: ' +
                                                        "${table9Data[index].totalNett}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Input Tax: ' +
                                                        "${table9Data[index].inputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Output Tax: ' +
                                                        "${table9Data[index].outputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Total Price: ' +
                                                        "${table9Data[index].totalSales}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Car".toString())
                                  Column(
                                    children: List.generate(
                                      table14Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Net Price: ' +
                                                        "${table14Data[index].totalNett}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Input Tax: ' +
                                                        "${table14Data[index].inputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Output Tax: ' +
                                                        "${table14Data[index].outputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Total Price: ' +
                                                        "${table14Data[index].totalSales}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Holiday".toString())
                                  Column(
                                    children: List.generate(
                                      table19Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Net Price: ' +
                                                        "${table19Data[index].totalNett}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Input Tax: ' +
                                                        "${table19Data[index].inputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Output Tax: ' +
                                                        "${table19Data[index].outputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Total Price: ' +
                                                        "${table19Data[index].totalSales}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Bus".toString())
                                  Column(
                                    children: List.generate(
                                      table24Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Net Price: ' +
                                                        "${table24Data[index].totalNett}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Input Tax: ' +
                                                        "${table24Data[index].inputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Output Tax: ' +
                                                        "${table24Data[index].outputTax}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Total Price: ' +
                                                        "${table24Data[index].totalSales}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Passengers Data",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                if (tableData[index].bookingType == "Flight")
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          tableData.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Passenger Name: ' +
                                                                "${table2Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table2Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table2Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table2Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table2Data[index].custPhone}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table2Data[index].custEmail}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Hotel".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table8Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Passenger Name: ' +
                                                                "${table8Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table8Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table8Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table8Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table8Data[index].tfpPhoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table8Data[index].tfpEmail}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Car".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table13Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Passenger Name: ' +
                                                                "${table13Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table13Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table13Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table13Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table13Data[index].tfpPhoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table13Data[index].tfpEmail}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Holiday".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table18Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Passenger Name: ' +
                                                                "${table18Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table18Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table18Data[index].dob}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table18Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table18Data[index].phoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table18Data[index].email}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Bus".toString())
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          table23Data.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
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
                                                            'Passenger Name: ' +
                                                                "${table23Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table23Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table23Data[index].dob}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Identity No: ' +
                                                                "${table23Data[index].idNumber}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table23Data[index].phoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 5,
                                                            top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table23Data[index].email}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                if (tableData[index].bookingType == "Flight")
                                  Text('No Data'),
                                if (tableData[index].bookingType ==
                                    "Hotel".toString())
                                  Column(
                                    children: List.generate(
                                      table40Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Room Description: ' +
                                                          "${table40Data[index].roomDescription}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Room Promotion: ' +
                                                          "${table40Data[index].roomPromotion}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Smoking Preference: ' +
                                                          "${table40Data[index].smokingPreference}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Amenity: ' +
                                                          "${table40Data[index].amenity}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Inclusion: ' +
                                                          "${table40Data[index].inclusion}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Hotel Policy:",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "      " +
                                                        "${table40Data[index].hotelPolicyDetail}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Cancellation Policy:",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "      " +
                                                        "${table40Data[index].cancellationPolicy}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (tableData[index].bookingType ==
                                    "Bus".toString())
                                  Column(
                                    children: List.generate(
                                      table39Data.length,
                                      (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Cancellation Charges: ' +
                                                          "${table39Data[index].cancellationCharge}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'From Date: ' +
                                                          "${table39Data[index].fromDate}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      'To Date: ' +
                                                          "${table39Data[index].toDate}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                      'Policy: ' +
                                                          "${table39Data[index].policyString}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ]),
                        ))),
                  );
                } catch (error) {
                  print('Unexpected error: $error');
                  return Text('An unexpected error occurred.');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
