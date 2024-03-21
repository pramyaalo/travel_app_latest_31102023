import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../../utils/commonutils.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'oneway_booking.dart';

class OnewayFlightsList extends StatefulWidget {
  final adult,
      orgin,
      destination,
      departDate,
      children,
      infants,
      userId,
      currency;

  const OnewayFlightsList({
    super.key,
    required this.adult,
    required this.children,
    required this.infants,
    required this.orgin,
    required this.destination,
    required this.departDate,
    required this.userId,
    required this.currency,
  });

  @override
  State<OnewayFlightsList> createState() => _OnewayFlightsListState();
}

class _OnewayFlightsListState extends State<OnewayFlightsList> {
  bool isLoading = false;
  var resultList = [];
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  String fin_date = '';

  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';

      sendFlightSearchRequest();
    });
  }

  void sendFlightSearchRequest() async {
    fin_date = widget.departDate.toString().split(' ')[0].replaceAll('-', '/');
    String origin = widget.orgin;
    String destination = widget.destination;

    var requestBody = {
      'AdultCount': widget.adult.toString(),
      'ChildrenCount': widget.children.toString(),
      'InfantCount': widget.infants.toString(),
      'DepartDate': fin_date,
      'Class': '3',
      'Origin': widget.orgin,
      'Destination': widget.destination,
      'TripType': 'OneWay',
      'DefaultCurrency': 'KES',
      'UserID': widget.userId,
    };
    print('widget.departDate ${fin_date}');
    print('widget.origin ${widget.orgin}');
    print('widget.destination ${widget.destination}');
    print('AdultCount: ${widget.adult}');
    print('ChildrenCount: ${widget.children}');
    print('InfantCount: ${widget.infants}');
    print('DepartDate: $fin_date');
    print('Class: 1');
    print('Origin: ${widget.orgin}');
    print('UserID: ${widget.userId}');
    print('DefaultCurrency: KES');
    var url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightOneWay');

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
        print('Request successful: ${response.statusCode}');
        var responseData =
            json.decode(ResponseHandler.parseData(response.body));
        print('Response data: $responseData');
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
              "Available Flights",
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
          ? ListView.builder(
              itemCount: 10, // Number of skeleton items
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: Container(
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount:
                            resultList.length > 20 ? 20 : resultList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Material(
                                elevation: 10,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 11),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 0),
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/images/img.png"),
                                                width: 50,
                                              ),
                                            ),
                                            Container(
                                              width: 69,
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                resultList[index]
                                                    ['CarrierName'],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              resultList[index]['Baggage'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 35),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDate']).toString().toUpperCase()} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Text(
                                                    ' ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDate']).toString().toUpperCase()}',
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
                                                  right: 25),
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
                                                                    'TravelTime']),
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
                                                                          'StopCount'] ==
                                                                      '0')
                                                                  ? "assets/images/NonStop.png"
                                                                  : (resultList[index]
                                                                              [
                                                                              'StopCount'] ==
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
                                                      ['DepartCityCode'],
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
                                                    '${resultList[index]['StopCount']} stops',
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
                                                      ['ArriveCityCode'],
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
                                            Container(
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.book_outlined,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                          resultList[index]
                                                              ['Refundable'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => OneWayBooking(
                                                                  flightDetails:
                                                                      resultList[
                                                                          index],
                                                                  adultCount:
                                                                      widget
                                                                          .adult,
                                                                  childrenCount:
                                                                      widget
                                                                          .children,
                                                                  infantCount: widget
                                                                      .infants,
                                                                  userid: widget
                                                                      .userId,
                                                                  currency: widget
                                                                      .currency,
                                                                  departDate:
                                                                      fin_date
                                                                          .toString())));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        }))
              ],
            ),
    );
  }
}
