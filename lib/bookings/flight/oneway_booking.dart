import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/commonutils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../utils/response_handler.dart';
import 'package:xml/xml.dart' as xml;

import '../../utils/shared_preferences.dart';
import 'FlightBookNow.dart';

class OneWayBooking extends StatefulWidget {
  //same error
  final dynamic flightDetails,
      adultCount,
      childrenCount,
      infantCount,
      userid,
      currency,
      departDate;
  const OneWayBooking(
      {super.key,
      required this.flightDetails,
      required this.infantCount,
      required this.childrenCount,
      required this.adultCount,
      required this.userid,
      required this.currency,
      required this.departDate});

  @override
  State<OneWayBooking> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<OneWayBooking> {
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

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
      print('Currency: $Currency');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getAdivahaFlightDetails();
    });
  }

  bool isLoading = false;
  bool isBookingLoading = false;

  List<Map<String, dynamic>> extractJsonFromXml(String xmlString) {
    // Parse the XML string
    var document = xml.XmlDocument.parse(xmlString);

    // Extract the JSON string from the XML string
    String jsonString = document.findAllElements('string').first.text;

    // Decode the JSON string into a list of maps
    List<Map<String, dynamic>> jsonList =
        json.decode(jsonString).cast<Map<String, dynamic>>();

    return jsonList;
  }

  TextEditingController passengerNameController = new TextEditingController();

  var resultFlightData = [];

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    //print(widget.flightDetails['ResultIndexID']);
    //print(widget.flightDetails['ItemId']);

    String resultIndex = widget.flightDetails['ResultIndexID'].toString();
    String traceId = widget.flightDetails['ItemId'].toString();

    print(resultIndex);
    print(traceId);
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: {
          'ResultIndex': resultIndex.toString(),
          'TraceId': traceId.toString(),
          'TripType': 'OneWay',
          'UserID': widget.userid.toString(),
          'DefaultCurrency': widget.currency.toString(),
        },
      );
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        //var jsonresp = ResponseHandler.parseData(response.body);
        //var tmp_resultFlightData = json.decode(extractJsonFromXml(response.body).toString());

        print('newww - jsonResulttt:');
        developer.log(extractJsonFromXml(response.body).toString());
        //developer.log(tmp_resultFlightData);
        setState(() {
          resultFlightData = extractJsonFromXml(response.body).toList();
          print('DepartCode : ${resultFlightData[0]['DepartCityCode']}');
        });

        //print('Request successful! Response: ${response.body}');
        // Handle the response data here
      } else {
        print('Request failed with status: ${response.statusCode}');
        // Handle the failure scenario
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle any exceptions or errors that occurred during the request
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
              "Flight Booking",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
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
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Color(0xffd9dce1),
                child: Column(
                  children: [
                    resultFlightData.length > 1
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resultFlightData.length > 1
                                ? resultFlightData.length - 1
                                : 0, //Ipo non stio kuduthu paarunga
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/img.png'),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              resultFlightData[index + 1]
                                                  ['CarrierName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            /* Text(
                                              'Air Asia',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),*/
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  resultFlightData[index + 1]
                                                          ['DepartureDate']
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                                Text(
                                                  '${CommonUtils.convertToFormattedTime(resultFlightData[index + 1]['DepartureDate']).toString().toUpperCase()} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(resultFlightData[index + 1]
                                                    ['DepartCityName']),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: 75,
                                                  child: Text(
                                                    resultFlightData[index + 1]
                                                        ['DepartAirportName'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    'Terminal' +
                                                        " " +
                                                        resultFlightData[
                                                                index + 1][
                                                            'DepartureTerminal'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Container(
                                              width: 65,
                                              child: Text(
                                                CommonUtils
                                                    .convertMinutesToHoursMinutes(
                                                        resultFlightData[index +
                                                            1]['TravelTime']),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  resultFlightData[index + 1]
                                                          ['ArrivalDate']
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                                Text(
                                                  '${CommonUtils.convertToFormattedTime(resultFlightData[index + 1]['ArrivalDate']).toString().toUpperCase()} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(resultFlightData[index + 1]
                                                    ['ArriveCityName']),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: 75,
                                                  child: Text(
                                                    resultFlightData[index + 1]
                                                        ['ArrivalAirportName'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    'Terminal' +
                                                        " " +
                                                        resultFlightData[
                                                                index + 1]
                                                            ['ArrivalTerminal'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  resultFlightData[index + 1]
                                                      ['Baggage'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'CheckIn\nBaggage',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  resultFlightData[index + 1]
                                                      ['CabinBaggage'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Cabin Baggage',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Meal',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                      //empty screen hello varutha?
                                    ),
                                  ), //Oruka stop pannitu run panni one stop varutha nnu confirm pannunga ok run se aagala list load aagathu ine epdi check pana
                                  index + 1 < (resultFlightData.length - 1)
                                      ? Container(
                                          width: double.infinity,
                                          color: Color(0xfff7f7f7),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                CommonUtils
                                                        .convertMinutesToHoursMinutes(
                                                            resultFlightData[
                                                                    index + 1][
                                                                'TravelTime']) +
                                                    " " +
                                                    "Layover",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(), //Run anathum screenshot anupunga ok
                                ],
                              );
                            })
                        : Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/img.png'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      resultFlightData[0]['CarrierName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    /* Text(
                                      'Air Asia',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.grey),
                                    ),*/
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resultFlightData[0]['DepartureDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData[0]['DepartureDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData[0]
                                            ['DepartCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          resultFlightData[0]
                                              ['DepartAirportName'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            'Terminal' +
                                                " " +
                                                resultFlightData[0]
                                                    ['DepartureTerminal'],
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Container(
                                      width: 65,
                                      child: Text(
                                        CommonUtils
                                            .convertMinutesToHoursMinutes(
                                                resultFlightData[0]
                                                    ['TravelTime']),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resultFlightData[0]['ArrivalDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData[0]['ArrivalDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData[0]
                                            ['ArriveCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          resultFlightData[0]
                                              ['ArrivalAirportName'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            'Terminal' +
                                                " " +
                                                resultFlightData[0]
                                                    ['ArrivalTerminal'],
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          resultFlightData[0]['Baggage'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'CheckIn\n Baggage',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          resultFlightData[0]['CabinBaggage'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Cabin Baggage',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Meal',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FlightBookNow(
                                        flightDetails: widget.flightDetails,
                                        resultFlightData: resultFlightData,
                                        adultCount: widget.adultCount,
                                        childrenCount: widget.childrenCount,
                                        infantCount: widget.infantCount,
                                        departdate: widget.departDate,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff74206b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                        child: Container(
                          width: 320,
                          height: 45,
                          alignment: Alignment.center,
                          child: Text(
                            'Book Flight',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
