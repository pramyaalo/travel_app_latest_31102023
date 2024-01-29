import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../utils/response_handler.dart';
import 'CommonUtils.dart';
import 'MultiCityBooking.dart';

class MultiCityFlightsList extends StatefulWidget {
  final adult,
      orgin,
      destination,
      orgin1,
      destination1,
      departDate,
      children,
      infants,
      returnDate;
  const MultiCityFlightsList({
    super.key,
    required this.adult,
    required this.children,
    required this.infants,
    required this.orgin,
    required this.destination,
    required this.orgin1,
    required this.destination1,
    required this.departDate,
    required this.returnDate,
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
    String origin = widget.orgin;
    String destination = widget.destination;

    print('widget.departDate ${fin_date}');
    print('widget.origin ${widget.adult}');
    print('widget.destination ${widget.adult}');
    var requestBody = {
      'OriginFirst': widget.orgin, // Replace with your actual origin
      'DestinationFirst':
          widget.destination, // Replace with your actual destination
      'OriginSecond': widget.orgin1, // Replace with your actual second origin
      'DestinationSecond':
          widget.destination1, // Replace with your actual second destination
      'DepartDateFirst':
          fin_date, // Replace with your actual first departure date
      'DepartDateSecond':
          fin_date1, // Replace with your actual second departure date
      'OriginThird': 'DXB', // Replace with your actual third origin
      'DestinationThird': 'MAA', // Replace with your actual third destination
      'DepartDateThird':
          '2024/02/14', // Replace with your actual third departure date
      'OriginFourth': 'MAA', // Replace with your actual fourth origin
      'DestinationFourth': 'DEL', // Replace with your actual fourth destination
      'DepartDateFourth':
          '2024/02/18', // Replace with your actual fourth departure date
      'AdultCount': widget.adult,
      'ChildrenCount': widget.children,
      'InfantCount': widget.infants,
      'Class': '1',
      'DefaultCurrency': 'INR'
    };

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightMultiWay');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    final body = Uri(queryParameters: requestBody).query;

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
        var jsonData = json.decode(ResponseHandler.parseData(response.body));

        setState(() {
          resultList = List<Map<String, dynamic>>.from(jsonData);
        });

        /*developer.log(
          'Response: ${resultList}',
          name: 'ResponseLogger',
        );*/

        // Handle response here
      } else {
        print('Error ${response.statusCode} : ${response.body}');
        // Handle error here
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle error here
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
              "MutiCity Flights",
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: resultList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Material(
                                elevation: 5,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/img.png',
                                                                height: 50,
                                                                width: 50,
                                                              )),
                                                          Text(
                                                            resultList[index][
                                                                    'CarrierNameFirst']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777)),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateFirst'].toString())} - ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateFirst'].toString())}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  resultList[index]
                                                                          [
                                                                          'DepartCityCodeFirst']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff777777),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          13)),
                                                              Icon(Icons
                                                                  .arrow_right_alt),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      resultList[index]
                                                                              [
                                                                              'ArriveCityCodeFirst']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff777777),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              13)),
                                                                  Text(
                                                                    ' ${resultList[index]['StopCountFirst'].toString()} stops',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container()
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/img.png',
                                                                height: 50,
                                                                width: 50,
                                                              )),
                                                          Text(
                                                            resultList[index][
                                                                    'CarrierNameSecond']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777)),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateSecond'].toString())} - ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateSecond'].toString())}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  resultList[index]
                                                                          [
                                                                          'DepartCityCodeSecond']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff777777),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          13)),
                                                              Icon(Icons
                                                                  .arrow_right_alt),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      resultList[index]
                                                                              [
                                                                              'ArriveCityCodeSecond']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff777777),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              13)),
                                                                  Text(
                                                                    ' ${resultList[index]['StopCountSecond'].toString()} stops',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container()
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${resultList[index]['Currency'].toString()} ${resultList[index]['TotalPrice'].toString()}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            resultList[index]['Refundable']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff11A578),
                                                fontSize: 13),
                                          ),
                                          Text(
                                            'Fare Details',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 13),
                                          ),
                                          Text(
                                            'More Details',
                                            style: TextStyle(
                                                color: Color(0xffdf7417),
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              navigate(MultiCityBooking(
                                  flightDetail: resultList[index]));
                            },
                          );
                        }))
              ],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    sendMultiWayFlightSearchRequest();
    super.initState();
  }
}
