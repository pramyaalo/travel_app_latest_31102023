import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:http/http.dart' as http;

import '../Models/airlines_ddl_model.dart';
import '../Models/hotel_destination_models.dart';
import '../Models/passenger_ddl_model.dart';
import '../utils/common_utils.dart';
import '../utils/response_handler.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({Key? key}) : super(key: key);

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  Future<http.Response>? __futureAirlinesDDL;
  List<AirlinesDDL> airlinesDDLList = [];

  final RoundedLoadingButtonController _btnAddController =
      RoundedLoadingButtonController();
  final TextEditingController _passengerNameController =
      TextEditingController();
  late TextEditingController textEditingController;

  Future<http.Response>? __futurePassengerDDL;
  List<PassengerDDL> passengerDDLList = [];

  String fromTextHolder = "";
  String toTextHolder = "";

  Future<http.Response>? __futurePassengerDependent;
  Future<http.Response>? __futurePassengerPolicy;

  List travelPolicyitems = [
    {"Id": 0, "Name": "-- Select --"}
  ];
  bool __shouldShowReturn = true;

  static String _displayOptionForAirportDDL(AirlinesDDL airlinesDDL) =>
      airlinesDDL.Name;
  static String _displayOptionForPassengerDDl(PassengerDDL passengerDDL) =>
      passengerDDL.Name;

  List<PassengerDDL> passengers = [];
  List<PassengerDDL> passengersFamily = [];
  late PassengerDDL selectedPassenger;

  //String tripValue = 'Round trip';
  List tripOptions = [
    {"Id": 0, "Name": "Round trip"},
    {"Id": 1, "Name": "One Way"},
    {"Id": 2, "Name": "Multi-City"},
  ];

  List businessClass = [
    {"Id": 0, "Name": "Economy"},
    {"Id": 1, "Name": "Premium"},
    {"Id": 2, "Name": "Business"},
    {"Id": 3, "Name": "First Class"},
  ];

  var tClassType = '0';
  var tpolicyID = '0';
  var tTripType = '0';
  var tFromCity = '';
  var tToCity = '';
  var tDepartDate = '';
  var tReturnDate = '';
  var tuserID = '';
  var tCorporateId = '';
  var tjsonTraveller = '';
  var tDefaultCurrency = 'SAR';

  DateTime selectedDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (type == 1) {
          selectedDate = picked;
        } else {
          selectedReturnDate = picked;
        }
      });
    }
  }

/*  @override
  void initState() {
    __futureAirlinesDDL = ResponseHandler.performPost(
        "BookingSearchAirportddl", 'CorporateId=1001');
    __futureAirlinesDDL?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      // log('jsonResponse ddl : $jsonResponse');

      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];

        for (int i = 0; i < list.length; i++) {
          AirlinesDDL airlinesDDL = AirlinesDDL.fromMap(list[i]);
          airlinesDDLList.add(airlinesDDL);
        }

        //log('Airlines list size: ' + airlinesDDLList.length.toString());
      } catch (e) {
        log("Exception" + e.toString());
      }
    });

    __futurePassengerDDL =
        ResponseHandler.performPost("TravellerDetails", "CorporateId=1001");
    __futurePassengerDDL?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];

        for (int i = 0; i < list.length; i++) {
          PassengerDDL passengerDDL = PassengerDDL.fromMap(list[i]);
          passengerDDLList.add(passengerDDL);
          log('Passenger Name : ' + passengerDDL.Name);
        }

        //log('Airlines list size: ' + airlinesDDLList.length.toString());
      } catch (e) {
        log("Exception" + e.toString());
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    String _travelPolicyValue = 'Policy 1';
    var _travelPolicy = [
      'Policy 1',
      'Policy 2',
    ];

    var travelPolicy = ['-- Select --'];

    List hotelDestination = [
      HotelDestination(
          title: "Month End Off",
          subtitle: "80% offer for this month",
          image:
              "https://www.yatra.com/ythomepagecms/media/todayspick/2020/Oct/98d57b3ddef131c2160085fff31776a1.jpg"),
      HotelDestination(
          title: "Coupons",
          subtitle: "Offer upto Rs.7000",
          image:
              "https://cdn.via.com/static/img/v1/newui/sg/general/offer/1503382796693_InternationalFlight_Offer_21.jpg"),
      HotelDestination(
          title: "Offers",
          subtitle: "Air India Offers",
          image:
              "https://www.airindia.in/writereaddata/Portal/CMS_Template_Banner/8_1_special-offer-banner.jpg"),
    ];

    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        color: Color(0xFF152238),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                        color: Colors.white,
                        child: Material(
                          elevation: 5,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffF0F5FB)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 125,
                                              height: 30,
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors
                                                        .blue), //https://stackoverflow.com/a/67395539/16076689
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                                color: Colors.white,
                                              ),
                                              child: DropdownButton(
                                                underline: SizedBox(),
                                                value: tTripType,
                                                iconSize: 0.0,
                                                // Array list of items
                                                items: tripOptions.map((items) {
                                                  return DropdownMenuItem(
                                                    value:
                                                        items['Id'].toString(),
                                                    child: Text(
                                                      items["Name"].toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 13),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (Object? value) {
                                                  setState(() {
                                                    tTripType =
                                                        value.toString();
                                                    if (tTripType == '0') {
                                                      __shouldShowReturn = true;
                                                    } else {
                                                      __shouldShowReturn =
                                                          false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: Container(
                                                width: 125,
                                                height: 30,
                                                padding: EdgeInsets.all(5),
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors
                                                          .blue), //https://stackoverflow.com/a/67395539/16076689
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white,
                                                ),
                                                child: DropdownButton(
                                                  underline: SizedBox(),

                                                  value: tClassType,
                                                  iconSize: 0.0,
                                                  // Array list of items
                                                  items: businessClass
                                                      .map((items) {
                                                    return DropdownMenuItem(
                                                      value: items['Id']
                                                          .toString(),
                                                      child: Text(
                                                        items['Name']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (Object? value) {
                                                    setState(() {
                                                      tClassType =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 145,
                                          child: Container(
                                            height: 30,
                                            padding: EdgeInsets.all(5),
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors
                                                      .blue), //https://stackoverflow.com/a/67395539/16076689
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                              color: Colors.white,
                                            ),
                                            child: DropdownButton(
                                              underline: SizedBox(),
                                              value: tpolicyID,
                                              iconSize: 0.0,
                                              isExpanded: true,
                                              // Array list of items
                                              hint: Text('Policy',
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 13)),
                                              items:
                                                  travelPolicyitems.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['Id'].toString(),
                                                  child: Text(
                                                      item['Name'].toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 13)),
                                                );
                                              }).toList(),
                                              onChanged: (Object? value) {
                                                setState(() {
                                                  //travelPolicyValue = value.toString();
                                                  tpolicyID = value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "From",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //Text("DEL", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                            SizedBox(
                                                width: 80,
                                                child:
                                                    Autocomplete<AirlinesDDL>(
                                                  displayStringForOption:
                                                      _displayOptionForAirportDDL,
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    if (textEditingValue.text ==
                                                        '') {
                                                      return const Iterable<
                                                          AirlinesDDL>.empty();
                                                    }
                                                    return airlinesDDLList
                                                        .where((AirlinesDDL
                                                            mData) {
                                                      return mData
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase());
                                                    });
                                                  },
                                                  fieldViewBuilder: (BuildContext
                                                          context,
                                                      TextEditingController
                                                          fieldTextEditingController,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onFieldSubmitted) {
                                                    return TextField(
                                                      controller:
                                                          fieldTextEditingController,
                                                      focusNode: fieldFocusNode,
                                                      decoration:
                                                          new InputDecoration
                                                              .collapsed(
                                                              hintText:
                                                                  'Orgin'),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  },
                                                  onSelected:
                                                      (AirlinesDDL mData) {
                                                    setState(() {
                                                      fromTextHolder = mData.Id;
                                                    });
                                                  },
                                                )),

                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '$fromTextHolder',
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Image(
                                            width: 40,
                                            height: 40,
                                            image: AssetImage(
                                                "assets/images/swap2.png")),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "To",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //Text("BOM", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                            SizedBox(
                                                width: 120,
                                                child:
                                                    Autocomplete<AirlinesDDL>(
                                                  displayStringForOption:
                                                      _displayOptionForAirportDDL,
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    if (textEditingValue.text ==
                                                        '') {
                                                      return const Iterable<
                                                          AirlinesDDL>.empty();
                                                    }
                                                    return airlinesDDLList
                                                        .where((AirlinesDDL
                                                            mData) {
                                                      return mData
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase());
                                                    });
                                                  },
                                                  fieldViewBuilder: (BuildContext
                                                          context,
                                                      TextEditingController
                                                          fieldTextEditingController,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onFieldSubmitted) {
                                                    return TextField(
                                                      controller:
                                                          fieldTextEditingController,
                                                      focusNode: fieldFocusNode,
                                                      decoration:
                                                          new InputDecoration
                                                              .collapsed(
                                                              hintText:
                                                                  'Destination'),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  },
                                                  onSelected:
                                                      (AirlinesDDL mData) {
                                                    setState(() {
                                                      toTextHolder = mData.Id;
                                                    });
                                                  },
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '$toTextHolder',
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Depart",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  _selectDate(context, 1);
                                                },
                                                child: Text(
                                                  "${selectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Saturday",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: __shouldShowReturn,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Return",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //Text("09 August 2022", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                              GestureDetector(
                                                  onTap: () {
                                                    _selectDate(context, 2);
                                                  },
                                                  child: Text(
                                                    "${selectedReturnDate.toLocal()}"
                                                        .split(' ')[0],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Friday",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Travellers",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //Text("1 Adult", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                            SizedBox(
                                              width: 150,
                                              child: Autocomplete<PassengerDDL>(
                                                displayStringForOption:
                                                    _displayOptionForPassengerDDl,
                                                optionsBuilder:
                                                    (TextEditingValue
                                                        textEditingValue) {
                                                  if (textEditingValue.text ==
                                                      '') {
                                                    return const Iterable<
                                                        PassengerDDL>.empty();
                                                  }
                                                  return passengerDDLList.where(
                                                      (PassengerDDL mData) {
                                                    return mData
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(
                                                            textEditingValue
                                                                .text
                                                                .toLowerCase());
                                                  });
                                                },
                                                fieldViewBuilder: (BuildContext
                                                        context,
                                                    TextEditingController
                                                        fieldTextEditingController,
                                                    FocusNode fieldFocusNode,
                                                    VoidCallback
                                                        onFieldSubmitted) {
                                                  textEditingController =
                                                      fieldTextEditingController;
                                                  return TextField(
                                                    controller:
                                                        fieldTextEditingController,
                                                    focusNode: fieldFocusNode,
                                                    decoration:
                                                        new InputDecoration
                                                            .collapsed(
                                                            hintText:
                                                                'Enter here'),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                },
                                                onSelected:
                                                    (PassengerDDL mData) {
                                                  setState(() {
                                                    selectedPassenger =
                                                        PassengerDDL(
                                                            Id: mData.Id,
                                                            Name: mData.Name,
                                                            Age: mData.Age);

                                                    //fromTextHolder = selectedPassenger.Name;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 100,
                                              child: RoundedLoadingButton(
                                                onPressed: () {
                                                  {
                                                    //passengers.add(selectedPassenger);
                                                    __futurePassengerDependent =
                                                        ResponseHandler.performPost(
                                                            "BookingSearchTravellersDependant",
                                                            "CorporateId=1001&TravellerID=" +
                                                                selectedPassenger
                                                                    .Id);
                                                    __futurePassengerDependent
                                                        ?.then((value) {
                                                      String jsonResponse =
                                                          ResponseHandler
                                                              .parseData(
                                                                  value.body);
                                                      log("Passenger jsonResponse: " +
                                                          jsonResponse);
                                                      try {
                                                        Map<String, dynamic>
                                                            map = json.decode(
                                                                jsonResponse);
                                                        List<dynamic> list =
                                                            map["Table"];

                                                        for (int i = 0;
                                                            i < list.length;
                                                            i++) {
                                                          PassengerDDL pd =
                                                              PassengerDDL
                                                                  .fromMap(
                                                                      list[i]);
                                                          passengersFamily
                                                              .add(pd);
                                                        }

                                                        setState(() {
                                                          PassengerDDL
                                                              tmpPassengerDetail;
                                                          tmpPassengerDetail = PassengerDDL(
                                                              Id: selectedPassenger
                                                                  .Id,
                                                              Name:
                                                                  "${selectedPassenger.Name} - ${selectedPassenger.Age} (P)",
                                                              Age:
                                                                  selectedPassenger
                                                                      .Age);
                                                          passengers.add(
                                                              tmpPassengerDetail);
                                                          passengersFamily.add(
                                                              selectedPassenger);
                                                        });
                                                        _btnAddController
                                                            .success();
                                                        textEditingController
                                                            .text = "";
                                                        //selectedPassenger = ();
                                                        Timer(
                                                            Duration(
                                                                seconds: 1),
                                                            () {
                                                          _btnAddController
                                                              .reset();
                                                        });
                                                      } catch (err) {
                                                        _btnAddController
                                                            .error();
                                                        Timer(
                                                            Duration(
                                                                seconds: 1),
                                                            () {
                                                          _btnAddController
                                                              .reset();
                                                        });

                                                        log(err.toString());
                                                      }
                                                    });

                                                    __futurePassengerPolicy =
                                                        ResponseHandler.performPost(
                                                            "BookingSearchTravellerWisePolicy",
                                                            "CorporateId=1001&TravellerID=" +
                                                                selectedPassenger
                                                                    .Id);
                                                    __futurePassengerPolicy
                                                        ?.then((value) {
                                                      String jsonResponse =
                                                          ResponseHandler
                                                              .parseData(
                                                                  value.body);
                                                      log("travelpolicyLength:prev " +
                                                          travelPolicyitems
                                                              .toString());
                                                      try {
                                                        Map<String, dynamic>
                                                            map = json.decode(
                                                                jsonResponse);
                                                        List<dynamic> list =
                                                            map["Table"];
                                                        List tmpPolicyList =
                                                            list;

                                                        setState(() {
                                                          //travelPolicyitems.add("-- Select --");
                                                          travelPolicyitems =
                                                              tmpPolicyList;
                                                          log("travelpolicyLength: " +
                                                              travelPolicyitems
                                                                  .toString());
                                                        });
                                                      } catch (err) {
                                                        log("errrr:" +
                                                            err.toString());
                                                      }
                                                    });
                                                  }
                                                  ;
                                                },
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat"),
                                                ),
                                                controller: _btnAddController,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.1,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    children: List.generate(
                                        passengersFamily.length, (index) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${passengersFamily[index].Name} - ${passengersFamily[index].Age}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            passengersFamily.removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .Id ==
                                                                    passengersFamily[
                                                                            index]
                                                                        .Id);
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: Icon(
                                                            Icons
                                                                .delete_forever_rounded,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 0.1,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Filters",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: true,
                                              onChanged: (st) {},
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Text(
                                              "Non-stop only",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => FlightListScreen()
                                              )
                                          );*/

                                            tjsonTraveller =
                                                jsonEncode("passengers");
                                            tDepartDate = selectedDate
                                                .toLocal()
                                                .toString();
                                            tReturnDate = selectedReturnDate
                                                .toLocal()
                                                .toString();
                                            tFromCity =
                                                fromTextHolder.toString();
                                            tToCity = toTextHolder.toString();

                                            if (tFromCity.isEmpty) {
                                              CommonUtilsSiva.showSnack(
                                                  context,
                                                  "Empty origin city. Please select a valid city",
                                                  CommonUtilsSiva.TYPE_ERROR);
                                            } else if (tToCity.isEmpty) {
                                              CommonUtilsSiva.showSnack(
                                                  context,
                                                  "Empty destination city. Please select a valid city",
                                                  CommonUtilsSiva.TYPE_ERROR);
                                            } else if (tpolicyID == '0') {
                                              CommonUtilsSiva.showSnack(
                                                  context,
                                                  "Policy is Empty. Please select a policy",
                                                  CommonUtilsSiva.TYPE_ERROR);
                                            } else {
                                              if (tTripType == '1') {
                                                /*  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            FlightListScreen(
                                                              jsonTraveller:
                                                                  tjsonTraveller,
                                                              policyID:
                                                                  tpolicyID,
                                                              userID: '1001',
                                                              CorporateId:
                                                                  '1001',
                                                              FromCity:
                                                                  tFromCity,
                                                              ToCity: tToCity,
                                                              DepartDate:
                                                                  tDepartDate
                                                                      .split(
                                                                          ' ')[0],
                                                              TripType:
                                                                  tTripType,
                                                              ClassType:
                                                                  tClassType,
                                                              DefaultCurrency:
                                                                  tDefaultCurrency,
                                                            )));*/
                                              } else if (tTripType == '0') {
                                                /*  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            FlightListScreenRound(
                                                              jsonTraveller:
                                                                  tjsonTraveller,
                                                              policyID:
                                                                  tpolicyID,
                                                              userID: '1001',
                                                              CorporateId:
                                                                  '1001',
                                                              FromCity:
                                                                  tFromCity,
                                                              ToCity: tToCity,
                                                              DepartDate:
                                                                  tDepartDate
                                                                      .split(
                                                                          ' ')[0],
                                                              ReturnDate:
                                                                  tReturnDate
                                                                      .split(
                                                                          ' ')[0],
                                                              TripType:
                                                                  tTripType,
                                                              ClassType:
                                                                  tClassType,
                                                              DefaultCurrency:
                                                                  tDefaultCurrency,
                                                            )));*/
                                              }
                                            }

                                            log("passegerJSON: " +
                                                tjsonTraveller);
                                            log("passegerJSON: " +
                                                tDepartDate.split(' ')[0]);
                                            log("passegerJSON: " +
                                                tReturnDate.split(' ')[0]);
                                            log("passegerJSON: " + tpolicyID);
                                            log("passegerJSON: " + tClassType);
                                            log("passegerJSON: " + tTripType);
                                            log("passegerJSON: " +
                                                tDefaultCurrency);
                                          },
                                          child: Text(
                                            "SEARCH",
                                            style: TextStyle(
                                                fontFamily: "Montserrat"),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 10.0,
                                            shadowColor: Colors.orange,
                                            primary: Colors.orange,
                                            padding: EdgeInsets.all(10.0),
                                            minimumSize: Size(150, 50.0),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 270,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text('Popular Holiday Destination',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              )),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                          ),
                          items: [
                            buildCarouselItem(
                                'London', 'assets/images/london.jpg'),
                            buildCarouselItem(
                                'Dubai', 'assets/images/dubai.jpg'),
                            buildCarouselItem(
                                'NEWYORK CITY', 'assets/images/newyork.png'),
                            buildCarouselItem(
                                'SWITZERLAND', 'assets/images/swiz.png'),
                            buildCarouselItem(
                                'VIETNAM', 'assets/images/vietnam.png'),
                            buildCarouselItem(
                                'BANGKOK', 'assets/images/bangkok.png'),
                            buildCarouselItem(
                                'MAURITIUS', 'assets/images/mauritius.png'),
                            buildCarouselItem(
                                'PARIS', 'assets/images/paris.png'),

                            buildCarouselItem(
                                'SINGAPORE', 'assets/images/singapore.jpg'),
                            // Add more items as needed
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildCarouselItem(String subtitle, String imagePath) {
  return Container(
    child: Card(
      color: Colors.white,
      elevation: 10.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: 55,
            color: Colors.black.withOpacity(0.6),
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "Montserrat",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
