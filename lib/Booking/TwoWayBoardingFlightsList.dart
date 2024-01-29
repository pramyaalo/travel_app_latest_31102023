import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/commonutils.dart';
import '../utils/response_handler.dart';
import 'TwoWayBooking.dart';

class TwoWayBoardingFlightsList extends StatefulWidget {
  final adult, children, infants, orgin, destination, departDate, returnDate;
  const TwoWayBoardingFlightsList(
      {super.key,
      required this.adult,
      required this.children,
      required this.infants,
      required this.orgin,
      required this.destination,
      required this.departDate,
      required this.returnDate});

  @override
  State<TwoWayBoardingFlightsList> createState() =>
      _TwoWayBoardingFlightsListState();
}

class _TwoWayBoardingFlightsListState extends State<TwoWayBoardingFlightsList> {
  var resultList = [];
  var resultFlightData = [];
  bool isLoading = false;
  bool isBookingLoading = false;

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  void sendFlightSearchRequest() async {
    String fin_date =
        widget.departDate.toString().split(' ')[0].replaceAll('-', '/');
    String fin_date1 =
        widget.returnDate.toString().split(' ')[0].replaceAll('-', '/');
    String origin = widget.orgin;
    String destination = widget.destination;
    print('widget.departDate ${fin_date}');
    print('widget.origin ${widget.adult}');
    print('widget.destination ${widget.adult}');
    // Replace these values with your actual data
    var requestBody = {
      'AdultCount': widget.adult,
      'ChildrenCount': widget.children,
      'InfantCount': widget.infants,
      'Origin': widget.orgin,
      'Destination': widget.destination,
      'fromCountry': 'India',
      'tocountry': 'Dubai',
      'DepartDate': fin_date,
      'ReturnDate': fin_date1
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
        print('Response: ${response.body}');

        setState(() {
          resultList = json.decode(ResponseHandler.parseData(response.body));
        });
      } else {
        print('Error ${response.statusCode} : ${response.body}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                "Available Flights",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 19),
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(2),
                    child: Material(
                      color: Colors.white,
                      elevation: 15,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 5, right: 5, bottom: 5, top: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset('assets/images/img.png'),
                                          Container(
                                            width: 65,
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              resultList[index]
                                                  ['CarrierNameForward'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                              color: Color(0xffededed)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/img.png'),
                                          Container(
                                            width: 65,
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              resultList[index]
                                                  ['CarrierNameForward'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateForward']).toString().toUpperCase()} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Text(
                                                    ' ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateForward']).toString().toUpperCase()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        CommonUtils
                                                            .convertMinutesToHoursMinutes(
                                                                resultList[
                                                                        index][
                                                                    'TravelTimeForward']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Image.asset(
                                                              (resultList[index]
                                                                          [
                                                                          'StopCountForward'] ==
                                                                      '0')
                                                                  ? "assets/images/NonStop.png"
                                                                  : (resultList[index]
                                                                              [
                                                                              'StopCountForward'] ==
                                                                          '1')
                                                                      ? "assets/images/oneStop.png"
                                                                      : "assets/images/TwoStop.png",
                                                              width: 200,
                                                              height: 20,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  resultList[index]
                                                      ['DepartCityCodeForward'],
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${resultList[index]['StopCountForward']} stops',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  /* if (int.parse(
                                                              resultList[index]
                                                                  ['StopCount']) >
                                                          0)
                                                        Text(
                                                          resultList[index]
                                                              ['ArriveCityCode'],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),*/
                                                ],
                                              ),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              Text(
                                                  resultList[index]
                                                      ['ArriveCityCodeForward'],
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                            ]),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            SizedBox(
                                              width: 250,
                                              height: 1,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffededed)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateForward']).toString().toUpperCase()} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Text(
                                                    ' ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateForward']).toString().toUpperCase()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        CommonUtils
                                                            .convertMinutesToHoursMinutes(
                                                                resultList[
                                                                        index][
                                                                    'TravelTimeForward']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Image.asset(
                                                              (resultList[index]
                                                                          [
                                                                          'StopCountForward'] ==
                                                                      '0')
                                                                  ? "assets/images/NonStop.png"
                                                                  : (resultList[index]
                                                                              [
                                                                              'StopCountForward'] ==
                                                                          '1')
                                                                      ? "assets/images/oneStop.png"
                                                                      : "assets/images/TwoStop.png",
                                                              width: 200,
                                                              height: 20,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  resultList[index]
                                                      ['DepartCityCodeForward'],
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${resultList[index]['StopCountForward']} stops',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  /* if (int.parse(
                                                          resultList[index]
                                                              ['StopCount']) >
                                                      0)
                                                    Text(
                                                      resultList[index]
                                                          ['ArriveCityCode'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),*/
                                                ],
                                              ),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              Text(
                                                  resultList[index]
                                                      ['ArriveCityCodeForward'],
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                            ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 250,
                                              height: 1,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffededed)),
                                              ),
                                            ),
                                            /*   Container(
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.book_outlined,
                                                  size: 14,
                                                ),
                                                Text(
                                                  resultList[index]
                                                      ['Refundable'],
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                "degftwr3ey" +
                                                    resultList[index],
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  /* Container(
                                width: 100,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text(
                                      '${resultList[index]['Currency']} ${resultList[index]['AdultTotalFare']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      'Round Trip',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )*/
                                ],
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.book_outlined,
                                          size: 14,
                                        ),
                                        Text(
                                          resultList[index]['Refundable'],
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              color: (resultList[index]
                                                          ['Refundable'] ==
                                                      'Refundable')
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                          "degftwr3ey" + resultList[index],
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
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
