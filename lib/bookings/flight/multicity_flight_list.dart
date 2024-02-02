import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

import '../../Booking/CommonUtils.dart';
import '../../utils/response_handler.dart';
import 'multicity_booking.dart';

class MultiCityFlightsList extends StatefulWidget {
  final adult,
      orgin,
      destination,
      orgin1,
      destination1,
      departDate,
      returnDate,
      children,
      infants;
  const MultiCityFlightsList({
    super.key,
    required this.adult,
    required this.orgin,
    required this.destination,
    required this.orgin1,
    required this.destination1,
    required this.departDate,
    required this.returnDate,
    required this.children,
    required this.infants,
  });

  @override
  State<MultiCityFlightsList> createState() => _MultiCityFlightsListState();
}

class _MultiCityFlightsListState extends State<MultiCityFlightsList> {
  List<dynamic> resultList = [];
  bool isLoading = false;

  Future<void> sendMultiWayFlightSearchRequest() async {
    String fin_date =
        widget.departDate.toString().split(' ')[0].replaceAll('-', '/');
    String fin_date1 =
        widget.returnDate.toString().split(' ')[0].replaceAll('-', '/');
    print('kjdhfkujh' + widget.destination1);
    var requestBody = {
      'OriginFirst': widget.orgin,
      'DestinationFirst': widget.destination,
      'OriginSecond': widget.orgin1,
      'DestinationSecond': widget.destination1,
      'DepartDateFirst': fin_date,
      'DepartDateSecond': fin_date1,
      'OriginThird': '',
      'DestinationThird': '',
      'DepartDateThird': '',
      'OriginFourth': '',
      'DestinationFourth': '',
      'DepartDateFourth': '',
      'AdultCount': widget.adult,
      'ChildrenCount': widget.children,
      'InfantCount': widget.infants,
      'Class': '1',
      'DefaultCurrency': 'INR'
    };
    print('OriginFirst: ${[widget.orgin]}');
    print('DestinationFirst: ${[widget.destination]}');
    print('OriginSecond: ${[widget.orgin1]}');
    print('DestinationSecond: ${[widget.destination1]}');
    print('DepartDateFirst: ${[fin_date]}');
    print('DepartDateSecond: ${[fin_date1]}');
    print('OriginThird: ${[' ']}');
    print('DestinationThird: ${[' ']}');
    print('DepartDateThird: ${[' ']}');
    print('OriginFourth: ${[' ']}');
    print('DestinationFourth: ${[' ']}');
    print('DepartDateFourth: ${[' ']}');
    print('AdultCount: ${[widget.adult]}');
    print('ChildrenCount: ${[widget.children]}');
    print('InfantCount: ${[widget.infants]}');
    print('Class: ${['1']}');
    print('DefaultCurrency: ${['INR']}');

    var url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightMultiWay');

    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: requestBody,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        print('Request failed with status: ${response.statusCode}');
        var responseData =
            json.decode(ResponseHandler.parseData(response.body));
        print('Request failed with status: ${responseData}');
        developer.log(ResponseHandler.parseData(response.body));

        setState(() {
          resultList = responseData;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  @override
  Widget build(BuildContext context) {
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
              "Multi City Flights",
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
                      padding:
                          EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
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
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      CommonUtils
                                                          .convertMinutesToHoursMinutes(
                                                              resultList[index][
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
                                                            (resultList[index][
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
                                                            fit:
                                                                BoxFit.fitWidth,
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
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
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      CommonUtils
                                                          .convertMinutesToHoursMinutes(
                                                              resultList[index][
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
                                                            (resultList[index][
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
                                                            fit:
                                                                BoxFit.fitWidth,
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      //TwoWayBooking
                                      /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TwoWayBooking(
                                        flightDetails: resultList[index],
                                      ),
                                    ),
                                  );*/
                                      print(
                                        "degftwr3ey" + resultList[index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
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
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    sendMultiWayFlightSearchRequest();
    super.initState();
  }
}
