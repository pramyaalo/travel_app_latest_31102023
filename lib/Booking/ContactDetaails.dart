import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/HolidayPassengerModel.dart';
import '../Models/HotelPassengerModel.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'CarAgentModel.dart';
import 'CarPassengerModel.dart';
import 'ContactAgentDetailModel.dart';
import 'HotelAgentModel.dart';
import 'PassengerModel.dart';

class ContactDetaails extends StatefulWidget {
  const ContactDetaails({super.key});

  @override
  State<ContactDetaails> createState() => _ContactDetaailsState();
}

class _ContactDetaailsState extends State<ContactDetaails> {
  static String savedId = '';
  String? savedName;
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
      table39,
      table40,
      table20,
      table21;
  List<BookedItemViewModel> tableData = [];
  List<PassengerModel> table2Data = [];
  List<ContactAgentDetailModel> table5Data = [];
  List<HotelPassengerModel> table8Data = [];
  List<HotelAgentModel> table10Data = [];
  List<CarPassengerModel> table13Data = [];
  List<HolidayPassengerModel> table18Data = [];
  List<CarAgentModel> table20Data = [];
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
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${savedId}&StaffId=0");
    print('jfghhjgh' + savedId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table2 = map["Table2"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
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

                  table5Data.clear();
                  if (table5.isNotEmpty) {
                    ContactAgentDetailModel m5 =
                        ContactAgentDetailModel.fromJson(table5[0]);
                    for (int i = 0; i < table5.length; i++) {
                      ContactAgentDetailModel t2Data =
                          ContactAgentDetailModel.fromJson(table5[i]);
                      table5Data.add(t2Data);
                      print(
                          'Index: $i, table5 Length: ${table5.length}, t1Data: $t2Data');
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
                  table10Data.clear();
                  if (table10.isNotEmpty) {
                    HotelAgentModel m10 = HotelAgentModel.fromJson(table10[0]);
                    for (int i = 0; i < table10.length; i++) {
                      HotelAgentModel t9Data =
                          HotelAgentModel.fromJson(table10[i]);
                      table10Data.add(t9Data);
                      print(
                          'Index: $i, Table6 Length: ${table10.length}, t1Data: $t9Data');
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
                  table20Data.clear();
                  if (table20.isNotEmpty) {
                    CarAgentModel m16 = CarAgentModel.fromJson(table20[0]);

                    for (int i = 0; i < table20.length; i++) {
                      CarAgentModel t20Data =
                          CarAgentModel.fromJson(table20[i]);
                      table20Data.add(t20Data);
                      print(
                          'Index: $i, Table12 Length: ${table20.length}, t1Data: $t20Data');
                    }
                  }
                  return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                            children: List.generate(
                                tableData.length,
                                (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Agent Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (tableData[index].bookingType ==
                                              "Flight")
                                            Column(
                                              children: List.generate(
                                                table5Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table5Data[
                                                                              index]
                                                                          .corporateName,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table5Data[
                                                                              index]
                                                                          .email,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table5Data[
                                                                              index]
                                                                          .phone,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Address',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table5Data[index].addressLine1 +
                                                                          table5Data[index]
                                                                              .addressLine2 +
                                                                          table5Data[index]
                                                                              .addressLine3,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (tableData[index].bookingType ==
                                              "Hotel")
                                            Column(
                                              children: List.generate(
                                                table10Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table10Data[
                                                                              index]
                                                                          .corporateName,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table10Data[
                                                                              index]
                                                                          .email,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table10Data[
                                                                              index]
                                                                          .phone,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Address',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table10Data[index].addressLine1 +
                                                                          table10Data[index]
                                                                              .addressLine2 +
                                                                          table10Data[index]
                                                                              .addressLine3,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (tableData[index].bookingType ==
                                              "Car")
                                            Column(
                                              children: List.generate(
                                                table20Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table20Data[
                                                                              index]
                                                                          .corporateName,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table20Data[
                                                                              index]
                                                                          .email,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table20Data[
                                                                              index]
                                                                          .phone,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Address',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table20Data[index].addressLine1 +
                                                                          table20Data[index]
                                                                              .addressLine2 +
                                                                          table20Data[index]
                                                                              .addressLine3,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Contact Information",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: PhysicalModel(
                                              color: Colors.white,
                                              elevation: 8,
                                              shadowColor:
                                                  const Color(0xff9a9ce3),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Text(
                                                            'Name',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Corporate1',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Text(
                                                            'Email',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'corporate1@gmail.com',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Text(
                                                            'Phone',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            '0645164489',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Text(
                                                            'Address',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 210,
                                                          child: Text(
                                                            '#13 First Cross st Annanager West',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "LBL User Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (tableData[index].bookingType ==
                                              "Flight")
                                            Column(
                                              children: List.generate(
                                                table2Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table2Data[
                                                                              index]
                                                                          .passenger,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table2Data[
                                                                              index]
                                                                          .tfpEmail,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table2Data[
                                                                              index]
                                                                          .tfpPhoneNo,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'DOB',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table2Data[
                                                                              index]
                                                                          .tfpDOB,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (tableData[index].bookingType ==
                                              "Hotel")
                                            Column(
                                              children: List.generate(
                                                table8Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table8Data[
                                                                              index]
                                                                          .passenger,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table8Data[
                                                                              index]
                                                                          .tfpEmail,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table8Data[
                                                                              index]
                                                                          .tfpPhoneNo,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'DOB',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table8Data[
                                                                              index]
                                                                          .tfpDOB,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (tableData[index].bookingType ==
                                              "Car")
                                            Column(
                                              children: List.generate(
                                                table13Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table13Data[
                                                                              index]
                                                                          .passenger,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table13Data[
                                                                              index]
                                                                          .tfpEmail,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table13Data[
                                                                              index]
                                                                          .tfpPhoneNo,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'DOB',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table13Data[
                                                                              index]
                                                                          .tfpDOB,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (tableData[index].bookingType ==
                                              "Holiday")
                                            Column(
                                              children: List.generate(
                                                table18Data.length,
                                                (index) => Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: PhysicalModel(
                                                        color: Colors.white,
                                                        elevation: 8,
                                                        shadowColor:
                                                            const Color(
                                                                0xff9a9ce3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table18Data[
                                                                              index]
                                                                          .passenger,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Email',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table18Data[
                                                                              index]
                                                                          .email,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'Phone',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      table18Data[
                                                                              index]
                                                                          .phoneNo,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    child: Text(
                                                                      'DOB',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 210,
                                                                    child: Text(
                                                                      table18Data[
                                                                              index]
                                                                          .dob,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ])))),
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
