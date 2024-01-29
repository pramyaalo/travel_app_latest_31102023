import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/commonutils.dart';
import '../../utils/response_handler.dart';

class TwoWayDomestic extends StatefulWidget {
  const TwoWayDomestic({super.key});

  @override
  State<TwoWayDomestic> createState() => _TwoWayDomesticState();
}

class _TwoWayDomesticState extends State<TwoWayDomestic> {
  int selectedOriginIndex = -1;
  int selectedReturnIndex = -1;

  bool isLoading = false;

  var departFlightList = [];
  var returnFlightList = [];

  late SelectedFlightModel departFlight;
  late SelectedFlightModel returnFlight;
  bool departFlightSelected = false, returnFlightSelected = false;

  void sendFlightSearchRequest() async {
    // Replace these values with your actual data
    var requestBody = {
      'AdultCount': '1',
      'ChildrenCount': '0',
      'InfantCount': '0',
      'Origin': 'DEL',
      'Destination': 'MAA',
      'fromCountry': 'India',
      'tocountry': 'India',
      'DepartDate': '2023/12/28',
      'ReturnDate': '2024/01/28'
    };

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightRoundWay');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Handle the response data here
        //print('Response: ${response.body}');

        var data = ResponseHandler.parseData(response.body);

        List<String> jsonStrings = data.split('|||');
        if (jsonStrings.length == 2) {
          List<List<dynamic>> jsonArrays = jsonStrings.map((jsonString) {
            List<dynamic> jsonArray = json.decode(jsonString);
            return jsonArray;
          }).toList();

          List<dynamic> firstJsonArray = jsonArrays[0];
          List<dynamic> secondJsonArray = jsonArrays[1];

          print('First JSON array: $firstJsonArray');
          print('Second JSON array: $secondJsonArray');

          setState(() {
            departFlightList = firstJsonArray;
            returnFlightList = secondJsonArray;
          });
        } else {
          print('Invalid data format');
        }
      } else {
        print('Error ${response.statusCode} : ${response.body}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flight Booking",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Select Boarding Flight',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              width: (MediaQuery.of(context).size.width) / 2,
                              height: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Container(
                                width:
                                    ((MediaQuery.of(context).size.width) / 2) -
                                        10,
                                child: ListView.builder(
                                    itemCount: departFlightList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedOriginIndex = index;
                                            departFlight = SelectedFlightModel(
                                                DepartCityCode:
                                                    returnFlightList[index]
                                                        ['DepartCityCode'],
                                                ArriveCityCode:
                                                    returnFlightList[index]
                                                        ['ArriveCityCode'],
                                                TotalPrice:
                                                    returnFlightList[index]
                                                        ['TotalPrice']);
                                            departFlightSelected = true;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 5,
                                            color: selectedOriginIndex == index
                                                ? Colors.orangeAccent
                                                : Colors.white,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/img.png',
                                                            height: 50,
                                                            width: 50,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        departFlightList[index]
                                                            ['CarrierName'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          departFlightList[
                                                                  index][
                                                              'DepartCityCode'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13)),
                                                      Icon(Icons
                                                          .arrow_right_alt),
                                                      Text(
                                                          departFlightList[
                                                                  index][
                                                              'ArriveCityCode'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${CommonUtils.convertToFormattedTime(departFlightList[index]['DepartureDate'])} - ${CommonUtils.convertToFormattedTime(departFlightList[index]['ArrivalDate'])}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${departFlightList[index]['StopCount']} Stops',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 13),
                                                      ),
                                                      Text(
                                                        '${departFlightList[index]['Currency']} ${departFlightList[index]['TotalPrice']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Select Return Flight',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              width:
                                  (MediaQuery.of(context).size.width) / 2 - 30,
                              height: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Container(
                                width:
                                    ((MediaQuery.of(context).size.width) / 2) -
                                        20,
                                child: ListView.builder(
                                    itemCount: returnFlightList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedReturnIndex = index;
                                            returnFlight = SelectedFlightModel(
                                                DepartCityCode:
                                                    returnFlightList[index]
                                                        ['DepartCityCode'],
                                                ArriveCityCode:
                                                    returnFlightList[index]
                                                        ['ArriveCityCode'],
                                                TotalPrice:
                                                    returnFlightList[index]
                                                        ['TotalPrice']);
                                            returnFlightSelected = true;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 5,
                                            color: selectedReturnIndex == index
                                                ? Colors.orangeAccent
                                                : Colors.white,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/img.png',
                                                            height: 50,
                                                            width: 50,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        returnFlightList[index]
                                                            ['CarrierName'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          returnFlightList[
                                                                  index][
                                                              'DepartCityCode'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13)),
                                                      Icon(Icons
                                                          .arrow_right_alt),
                                                      Text(
                                                          returnFlightList[
                                                                  index][
                                                              'ArriveCityCode'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${CommonUtils.convertToFormattedTime(returnFlightList[index]['DepartureDate'])} - ${CommonUtils.convertToFormattedTime(returnFlightList[index]['ArrivalDate'])}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${returnFlightList[index]['StopCount']} Stops',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 13),
                                                      ),
                                                      Text(
                                                        '${returnFlightList[index]['Currency']} ${returnFlightList[index]['TotalPrice']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  departFlightSelected && returnFlightSelected
                      ? Material(
                          elevation: 10,
                          color: Theme.of(context).primaryColor,
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            width: MediaQuery.of(context).size.width - 0,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(departFlight.DepartCityCode,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13)),
                                          Icon(
                                            Icons.arrow_right_alt,
                                            color: Colors.white,
                                          ),
                                          Text(departFlight.ArriveCityCode,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(returnFlight.DepartCityCode,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13)),
                                          Icon(
                                            Icons.arrow_right_alt,
                                            color: Colors.white,
                                          ),
                                          Text(returnFlight.ArriveCityCode,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'INR ${double.parse(departFlight.TotalPrice) + double.parse(returnFlight.TotalPrice)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Book',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    sendFlightSearchRequest();
    super.initState();
  }
}

class SelectedFlightModel {
  String DepartCityCode, ArriveCityCode, TotalPrice;

  SelectedFlightModel(
      {required this.DepartCityCode,
      required this.ArriveCityCode,
      required this.TotalPrice});
}
