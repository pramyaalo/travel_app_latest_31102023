import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Booking/FamilyMembersModel.dart';
import '../../Booking/MultiCityFlightsList.dart';
import '../../Booking/TwoWayBoardingFlightsList.dart';
import '../../Models/passenger_ddl_model.dart';
import '../../models/hotel_destination_models.dart';

import '../../utils/response_handler.dart';
import 'AddTravellers_Flight.dart';
import 'one_way_flight_list.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightScreen> {
  bool __shouldShowReturn = true;
  bool isMulti = false;
  bool _isPassengersLoading = true;
  String Economy = '',
      PremiumEconomy = '',
      Business = '',
      isFirstSelected = '',
      selectedClass = '';
  int AdultCount = 1, childrenCount = 0, infantsCount = 0;
  String displayText1 = '';
  static String _displayOptionForPassengerDDl(PassengerDDL passengerDDL) =>
      passengerDDL.Name;

  TextEditingController orginController = new TextEditingController();
  TextEditingController orginController1 = new TextEditingController();

  TextEditingController destinationController = new TextEditingController();
  TextEditingController destinationController1 = new TextEditingController();

  final RoundedLoadingButtonController _btnAddController =
      RoundedLoadingButtonController();

  //String tripValue = 'Round trip';
  List tripOptions = [
    {"Id": 0, "Name": "Round trip"},
    {"Id": 1, "Name": "One Way"},
    {"Id": 2, "Name": "Multi-City"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    orginController.text = 'DEL';
    destinationController.text = 'MAA';
    orginController1.text = 'MAA';
    destinationController1.text = 'DXB';
    //searchBookingTravellers();
    isSelected = true;
    __shouldShowReturn = false;
    //_loadSavedString();
    if (selectedClass == '') {
      selectedClass = 'Economy';
    }
    tTripType = '1';
    super.initState();
  }

  /*_loadSavedString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      AdultCount = prefs.getInt('adultsCount') ?? 0;
      childrenCount = prefs.getInt('childrenCount') ?? 0;
      infantsCount = prefs.getInt('infantsCount') ?? 0;
      Economy = prefs.getString('isEconomySelected') ?? '';
      PremiumEconomy = prefs.getString('PremiumEconomy') ?? '';
      Business = prefs.getString('Business') ?? '';
      isFirstSelected = prefs.getString('isFirstSelected') ?? '';
      print('Adults Count: $AdultCount');
      print('Children Count: $childrenCount');
      print('Infants Count: $infantsCount');
      print('Is Economy Selected: $Economy');
      print('Premium Economy: $PremiumEconomy');
      print('Business: $Business');
      print('Is First Selected: $isFirstSelected');
    });
  }*/

  _saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('adultsCount', AdultCount);
    prefs.setInt('childrenCount', childrenCount);
    prefs.setInt('infantsCount', infantsCount);
    setState(() {
      prefs.setString('isEconomySelected', Economy);
      prefs.setString('PremiumEconomy', PremiumEconomy);
      prefs.setString('Business', Business);
      prefs.setString('isFirstSelected', isFirstSelected);
    });
  }

  List businessClass = [
    {"Id": 0, "Name": "Economy"},
    {"Id": 1, "Name": "Premium"},
    {"Id": 2, "Name": "Business"},
    {"Id": 3, "Name": "First Class"},
  ];
  String firstDropdownValue = '0';
  String secondDropdownValue = '0';
  String thirdDropdownValue = '0';

  List<String> numbers = List.generate(10, (index) => index.toString());

  List<String> commonOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  var tClassType = '0';
  var tpolicyID = '-1';
  String tTripType = '0';
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

  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    void navigate(Widget screen) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
    }

    if (Economy != '') {
      displayText1 = Economy;
      print('Is Economy Selected: $displayText1');
    }
    if (PremiumEconomy != '') {
      displayText1 = PremiumEconomy;
      print('Is Economy Selected: $displayText1');
    }
    if (Business != '') {
      displayText1 = Business;
      print('Is Economy Selected: $displayText1');
    }
    if (isFirstSelected != '') {
      displayText1 = isFirstSelected;
      print('Is Economy Selected: $displayText1');
    }
    String adultsText = AdultCount > 1 ? '$AdultCount Adults' : '1 Adult';
    String childrenText = childrenCount > 0 ? '$childrenCount Children' : '';
    String InfantCount = infantsCount > 0 ? '$infantsCount Infants' : '';

    String Adult = '$adultsText ';
    String Children = '$childrenText';
    String Infants = '$InfantCount';
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Flight Booking",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tTripType = '1';
                                      __shouldShowReturn = false;
                                      isSelected = true;
                                      isSelected1 = false;
                                      isSelected2 = false;
                                      print('object' + tTripType!.toString());
                                    });
                                  },
                                  child: Container(
                                    width: 97,
                                    padding: EdgeInsets.only(
                                        left: 5, bottom: 6, right: 5, top: 6),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.pink.shade50
                                          : Colors.white,
                                      border: Border.all(
                                          color: isSelected
                                              ? Color(0xff74206b)
                                              : Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'One-way',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Color(0xff74206b)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tTripType = '0';
                                      __shouldShowReturn = true;
                                      isSelected1 = true;
                                      isSelected = false;
                                      isSelected2 = false;
                                      print('object' + isSelected1!.toString());
                                    });
                                  },
                                  child: Container(
                                    width: 97,
                                    padding: EdgeInsets.only(
                                        left: 5, bottom: 6, right: 5, top: 6),
                                    decoration: BoxDecoration(
                                      color: isSelected1
                                          ? Colors.pink.shade50
                                          : Colors.white,
                                      border: Border.all(
                                          color: isSelected1
                                              ? Color(0xff74206b)
                                              : Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Roundtrip',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected1
                                            ? Color(0xff74206b)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tTripType = '2';
                                      isSelected1 = false;
                                      isSelected = false;
                                      isSelected2 = true;
                                      print('objecwdewet' +
                                          isSelected2!.toString());
                                    });
                                  },
                                  child: Container(
                                    width: 97,
                                    padding: EdgeInsets.only(
                                        left: 5, bottom: 6, right: 5, top: 6),
                                    decoration: BoxDecoration(
                                      color: isSelected2
                                          ? Colors.pink.shade50
                                          : Colors.white,
                                      border: Border.all(
                                          color: isSelected2
                                              ? Color(0xff74206b)
                                              : Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Multi-City',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected2
                                            ? Color(0xff74206b)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 0),
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'From',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(), // Add some space between "From" and "To"
                                  Text(
                                    'Destination',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(right: 0, left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: orginController,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Spacer(), // Add some space between the text field and the image
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child:
                                        Image.asset("assets/images/swap2.png"),
                                  ),
                                  Spacer(), // Add some space between the image and the text field
                                  Expanded(
                                    child: TextField(
                                      controller: destinationController,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  /* Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: orginController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ABC',
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),*/
                                  /* Image(
                                      width: 40,
                                      height: 40,
                                      image: AssetImage(
                                          "assets/images/swap2.png")),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: destinationController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'DEF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )*/
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delhi',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(), // Add some space between "From" and "To"
                                  Text(
                                    'Chennai',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  /* Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: orginController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ABC',
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),*/
                                  /* Image(
                                      width: 40,
                                      height: 40,
                                      image: AssetImage(
                                          "assets/images/swap2.png")),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: destinationController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'DEF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )*/
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Visibility(
                              visible: tTripType == '2',
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 0),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'From',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(), // Add some space between "From" and "To"
                                        Text(
                                          'Destination',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(right: 0, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: orginController1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Spacer(), // Add some space between the text field and the image
                                        Container(
                                          width: 25,
                                          height: 25,
                                          child: Image.asset(
                                              "assets/images/swap2.png"),
                                        ),
                                        Spacer(), // Add some space between the image and the text field
                                        Expanded(
                                          child: TextField(
                                            controller: destinationController1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        /* Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: orginController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ABC',
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),*/
                                        /* Image(
                                      width: 40,
                                      height: 40,
                                      image: AssetImage(
                                          "assets/images/swap2.png")),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: destinationController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'DEF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )*/
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Delhi',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(), // Add some space between "From" and "To"
                                        Text(
                                          'Chennai',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        /* Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: orginController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ABC',
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),*/
                                        /* Image(
                                      width: 40,
                                      height: 40,
                                      image: AssetImage(
                                          "assets/images/swap2.png")),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: TextField(
                                          controller: destinationController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'DEF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )*/
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Depart",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Saturday",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: __shouldShowReturn
                                        ? () {
                                            // Handle the tap when __shouldShowReturn is true
                                            _selectDate(context, 2);
                                          }
                                        : null, // Set onTap to null when __shouldShowReturn is false
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          __shouldShowReturn
                                              ? "${selectedReturnDate.toLocal()}"
                                                  .split(' ')[0]
                                              : "Select Date",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: __shouldShowReturn
                                                ? Colors.black
                                                : Colors.black38,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          __shouldShowReturn
                                              ? "Friday"
                                              : "book return",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                              padding: EdgeInsets.only(bottom: 0),
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Travellers',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(), // Add some space between "From" and "To"
                                  Text(
                                    'Class',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 0),
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      _saveString();
                                      final selectedDates =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          AddTravellers_Flight(
                                                            adultsCount:
                                                                AdultCount,
                                                            childrenCount:
                                                                childrenCount,
                                                            infantsCount:
                                                                infantsCount,
                                                            selectedClass:
                                                                selectedClass,
                                                          )));
                                      if (selectedDates != null) {
                                        setState(() {
                                          AdultCount =
                                              selectedDates['adultsCount'];
                                          childrenCount =
                                              selectedDates['childrenCount'];
                                          infantsCount =
                                              selectedDates['infantCount'];
                                          selectedClass =
                                              selectedDates['selectedClass'];
                                          print(
                                              'selectedClass' + selectedClass);
                                        });
                                      }
                                    },
                                    child: Text(
                                      Children + Adult + Infants,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(), // Add some space between "From" and "To"
                                  Text(
                                    selectedClass,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*  Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF0F5FB)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 30,
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors
                                                  .white), //https://stackoverflow.com/a/67395539/16076689
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                          color: Colors.white,
                                        ),
                                        child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          underline: SizedBox(),
                                          value: tTripType,
                                          iconSize: 0.0,
                                          // Array list of items
                                          items: tripOptions.map((items) {
                                            return DropdownMenuItem(
                                              value: items['Id'].toString(),
                                              child: Text(
                                                items["Name"].toString(),
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 13),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (Object? value) {
                                            setState(() {
                                              tTripType = value.toString();
                                              print('objecdfrt' + tTripType);
                                              if (tTripType == '0') {
                                                __shouldShowReturn = true;
                                              } else {
                                                __shouldShowReturn = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: Container(
                                          width: 140,
                                          height: 30,
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors
                                                    .white), //https://stackoverflow.com/a/67395539/16076689
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: DropdownButton(
                                            dropdownColor: Colors.white,
                                            underline: SizedBox(),

                                            value: tClassType,
                                            iconSize: 0.0,
                                            // Array list of items
                                            items: businessClass.map((items) {
                                              return DropdownMenuItem(
                                                value: items['Id'].toString(),
                                                child: Text(
                                                  items['Name'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 13),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (Object? value) {
                                              setState(() {
                                                tClassType = value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 46,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (tTripType == '0') {
                                            //navigate(TwoWayDomestic());
                                            navigate(TwoWayBoardingFlightsList(
                                              adult: AdultCount.toString(),
                                              children:
                                                  childrenCount.toString(),
                                              infants: infantsCount.toString(),
                                              orgin: orginController.text,
                                              destination:
                                                  destinationController.text,
                                              departDate: selectedDate,
                                              returnDate: selectedReturnDate,
                                            ));
                                          } else if (tTripType == "1") {
                                            print(
                                                'sfdf' + orginController.text);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OnewayFlightsList(
                                                          adult: AdultCount
                                                              .toString(),
                                                          children:
                                                              childrenCount
                                                                  .toString(),
                                                          infants: infantsCount
                                                              .toString(),
                                                          orgin: orginController
                                                              .text,
                                                          destination:
                                                              destinationController
                                                                  .text,
                                                          departDate:
                                                              selectedDate),
                                                ));
                                          } else
                                            navigate(MultiCityFlightsList(
                                                adult: AdultCount.toString(),
                                                children:
                                                    childrenCount.toString(),
                                                infants:
                                                    infantsCount.toString(),
                                                orgin: orginController.text,
                                                destination:
                                                    destinationController.text,
                                                orgin1: orginController1.text,
                                                destination1:
                                                    destinationController1.text,
                                                returnDate: selectedReturnDate,
                                                departDate: selectedDate));
                                        },
                                        child: Text(
                                          "SEARCH",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff74206b),

                                          // Background color of the button
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // Circular radius of 20
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
            Column(
              children: [
                Container(
                  height: 231,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 330,
                        height: 200,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Card(
                          elevation: 10.0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: 330,
                                height: 200,
                                /*child: Image(
                      image: NetworkImage(hotelDestination[index].image),
                      fit: BoxFit.fill,
                    ),*/
                                child: CachedNetworkImage(
                                  imageUrl: hotelDestination[index].image,
                                  placeholder: (context, url) => Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                  width: 330,
                                  height: 55,
                                  color: Colors.black.withOpacity(0.6),
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotelDestination[index].title,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              hotelDestination[index].subtitle,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Explore",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            elevation: 16.0),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: hotelDestination.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

Widget buildDropdown(
    List<String> items, String value, Function(Object?) onChanged) {
  return Container(
    width: 120,
    height: 30,
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: DropdownButton(
      dropdownColor: Colors.white,
      underline: SizedBox(),
      value: value,
      iconSize: 0.0,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
