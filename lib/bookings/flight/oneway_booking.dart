import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/commonutils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../utils/response_handler.dart';

class OneWayBooking extends StatefulWidget {
  //same error
  final dynamic flightDetails;
  const OneWayBooking({super.key, required this.flightDetails});

  @override
  State<OneWayBooking> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<OneWayBooking> {
  bool isLoading = false;
  bool isBookingLoading = false;

  TextEditingController passengerNameController = new TextEditingController();

  var resultFlightData;

  //heloooo0ooooooooo
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
          'TripType': 'OneWay'
        },
      );
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var jsonresp = ResponseHandler.parseData(response.body);
        var tmp_resultFlightData = json.decode(jsonresp);

        print('newww - jsonResulttt:');
        developer.log(tmp_resultFlightData);
        //developer.log(tmp_resultFlightData);
        setState(() {
          //resultFlightData = tmp_resultFlightData;
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

  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightBooking');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];

    var reqBody = {
      'ResultIndex': resultIndex,
      'TraceId': traceId,
      'LCC': resultFlightData[0]['IsLCC'].toString(),
      'TripType': 'Oneway',
      'UserId': '' /* widget.selectedPassenger.Id.toString()*/,
      'TravelPolicy': 'InPolicy',
      'TravelPolicyId': '' /*widget.policyId.toString()*/,
      'AdultCount': '1',
      'ChildCount': '0',
      'InfantCount': '0',
      'BookingCurrency': resultFlightData[0]['BookingCurrency'].toString(),
      'BookingBaseFare': resultFlightData[0]['BookingBaseFare'].toString(),
      'BookingTax': resultFlightData[0]['BookingTax'].toString(),
      'BookingYQTax': resultFlightData[0]['BookingYQTax'].toString(),
      'BookingAdditionalTxnFeePub':
          resultFlightData[0]['BookingAdditionalTxnFeePub'].toString(),
      'BookingAdditionalTxnFeeOfrd':
          resultFlightData[0]['BookingAdditionalTxnFeeOfrd'].toString(),
      'BookingOtherCharges':
          resultFlightData[0]['BookingOtherCharges'].toString(),
      'BookingDiscount': resultFlightData[0]['BookingDiscount'].toString(),
      'BookingPublishedFare':
          resultFlightData[0]['BookingPublishedFare'].toString(),
      'BookingOfferedFare':
          resultFlightData[0]['BookingOfferedFare'].toString(),
      'BookingTdsOnCommission':
          resultFlightData[0]['BookingTdsOnCommission'].toString(),
      'BookingTdsOnPLB': resultFlightData[0]['BookingTdsOnPLB'].toString(),
      'BookingTdsOnIncentive':
          resultFlightData[0]['BookingTdsOnIncentive'].toString(),
      'BookingServiceFee': resultFlightData[0]['BookingServiceFee'].toString(),
      'GSTCompanyAddress': '',
      'GSTCompanyContactNumber': '',
      'GSTCompanyName': '',
      'GSTNumber': '',
      'GSTCompanyEmail': '',
      'TitleAdult1': 'Mrs',
      'FNameAdult1': 'Shanthini Vasan',
      'LNameAdult1': 'K',
      'LDOBAdult1': '1990/01/01',
      'GenderAdult1': '1',
      'DocNumAdult1': '65757657655',
      'ExpDateAdult1': '2025/01/01',
      'TitleAdult2': '',
      'FNameAdult2': '',
      'LNameAdult2': '',
      'LDOBAdult2': '',
      'GenderAdult2': '',
      'DocNumAdult2': '',
      'ExpDateAdult2': '',
      'TitleAdult3': '',
      'FNameAdult3': '',
      'LNameAdult3': '',
      'LDOBAdult3': '',
      'GenderAdult3': '',
      'DocNumAdult3': '',
      'ExpDateAdult3': '',
      'TitleAdult4': '',
      'FNameAdult4': '',
      'LNameAdult4': '',
      'LDOBAdult4': '',
      'GenderAdult4': '',
      'DocNumAdult4': '',
      'ExpDateAdult4': '',
      'TitleAdult5': '',
      'FNameAdult5': '',
      'LNameAdult5': '',
      'LDOBAdult5': '',
      'GenderAdult5': '',
      'DocNumAdult5': '',
      'ExpDateAdult5': '',
      'TitleAdult6': '',
      'FNameAdult6': '',
      'LNameAdult6': '',
      'LDOBAdult6': '',
      'GenderAdult6': '',
      'DocNumAdult6': '',
      'ExpDateAdult6': '',
      'TitleAdult7': '',
      'FNameAdult7': '',
      'LNameAdult7': '',
      'LDOBAdult7': '',
      'GenderAdult7': '',
      'DocNumAdult7': '',
      'ExpDateAdult7': '',
      'TitleAdult8': '',
      'FNameAdult8': '',
      'LNameAdult8': '',
      'LDOBAdult8': '',
      'GenderAdult8': '',
      'DocNumAdult8': '',
      'ExpDateAdult8': '',
      'TitleAdult9': '',
      'FNameAdult9': '',
      'LNameAdult9': '',
      'LDOBAdult9': '',
      'GenderAdult9': '',
      'DocNumAdult9': '',
      'ExpDateAdult9': '',
      'TitleAdult10': '',
      'FNameAdult10': '',
      'LNameAdult10': '',
      'LDOBAdult10': '',
      'GenderAdult10': '',
      'DocNumAdult10': '',
      'ExpDateAdult10': '',
      'TitleChild1': '',
      'FNameChild1': '',
      'LNameChild1': '',
      'LDOBChild1': '',
      'GenderChild1': '',
      'DocNumChild1': '',
      'ExpDateChild1': '',
      'TitleChild2': '',
      'FNameChild2': '',
      'LNameChild2': '',
      'LDOBChild2': '',
      'GenderChild2': '',
      'DocNumChild2': '',
      'ExpDateChild2': '',
      'TitleChild3': '',
      'FNameChild3': '',
      'LNameChild3': '',
      'LDOBChild3': '',
      'GenderChild3': '',
      'DocNumChild3': '',
      'ExpDateChild3': '',
      'TitleChild4': '',
      'FNameChild4': '',
      'LNameChild4': '',
      'LDOBChild4': '',
      'GenderChild4': '',
      'DocNumChild4': '',
      'ExpDateChild4': '',
      'TitleChild5': '',
      'FNameChild5': '',
      'LNameChild5': '',
      'LDOBChild5': '',
      'GenderChild5': '',
      'DocNumChild5': '',
      'ExpDateChild5': '',
      'TitleInfant1': '',
      'FNameInfant1': '',
      'LNameInfant1': '',
      'LDOBInfant1': '',
      'GenderInfant1': '',
      'DocNumInfant1': '',
      'ExpDateInfant1': '',
      'TitleInfant2': '',
      'FNameInfant2': '',
      'LNameInfant2': '',
      'LDOBInfant2': '',
      'GenderInfant2': '',
      'DocNumInfant2': '',
      'ExpDateInfant2': '',
      'TitleInfant3': '',
      'FNameInfant3': '',
      'LNameInfant3': '',
      'LDOBInfant3': '',
      'GenderInfant3': '',
      'DocNumInfant3': '',
      'ExpDateInfant3': '',
      'TitleInfant4': '',
      'FNameInfant4': '',
      'LNameInfant4': '',
      'LDOBInfant4': '',
      'GenderInfant4': '',
      'DocNumInfant4': '',
      'ExpDateInfant4': '',
      'TitleInfant5': '',
      'FNameInfant5': '',
      'LNameInfant5': '',
      'LDOBInfant5': '',
      'GenderInfant5': '',
      'DocNumInfant5': '',
      'ExpDateInfant5': '',
      'Address': 'New Street',
      'City': 'Nagercoil',
      'CountryCode': 'IN',
      'CountryName': 'India',
      'MobileNumber': '9988776655',
      'Email': 'abc@abc.com',
      'AdultTravellerID1': '' /*widget.selectedPassenger.Id.toString()*/,
      'AdultTravellerID2': '',
      'AdultTravellerID3': '',
      'AdultTravellerID4': '',
      'AdultTravellerID5': '',
      'AdultTravellerID6': '',
      'AdultTravellerID7': '',
      'AdultTravellerID8': '',
      'AdultTravellerID9': '',
      'AdultTravellerID10': ''
    };
    try {
      setState(() {
        isBookingLoading = true;
      });
      //developer.log(reqBody.toString());
      final response = await http.post(
        url,
        headers: headers,
        body: reqBody,
      );

      //developer.log(reqBody.toString());

      setState(() {
        isBookingLoading = false;
      });
      if (response.statusCode == 200) {
        ////print('Request successful! Response: ${response.body}');
        developer.log(response.body);
        // Handle the response data here
      } else {
        //print(
        //'Request failed with status: ${response.statusCode} : ${response.body}');
        // Handle the failure scenario
      }
    } catch (error) {
      //print('Error sending request: $error');
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    elevation: 15,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          widget
                                              .flightDetails['DepartCityCode'],
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: (widget.flightDetails[
                                                        'StopCount'] ==
                                                    '0')
                                                ? Image.asset(
                                                    "assets/images/NonStop.png",
                                                    width: 230,
                                                    height: 20,
                                                    fit: BoxFit.fitWidth,
                                                  )
                                                : (widget.flightDetails[
                                                            'StopCount'] ==
                                                        '1')
                                                    ? Image.asset(
                                                        "assets/images/oneStop.png",
                                                        width: 230,
                                                        height: 20,
                                                        fit: BoxFit.fitWidth,
                                                      )
                                                    : Image.asset(
                                                        "assets/images/TwoiStop.png",
                                                        width: 230,
                                                        height: 20,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          widget
                                              .flightDetails['ArriveCityCode'],
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                widget.flightDetails[
                                                    'DepartCityName'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  CommonUtils
                                                      .convertMinutesToHoursMinutes(
                                                          widget.flightDetails[
                                                              'TravelTime']),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 75,
                                              ),
                                              Text(
                                                widget.flightDetails[
                                                    'ArriveCityName'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                /*  Row(children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(widget.flightDetails['DepartCityCode'],
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
                                            '${widget.flightDetails['StopCount']} stops',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          if (int.parse(widget
                                                  .flightDetails['StopCount']) >
                                              0)
                                            Text(
                                              'Text',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(widget.flightDetails['ArriveCityCode'],
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                    ]),*/
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 290,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: Color(0xffededed)),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Changed to start
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Changed to start
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, bottom: 0),
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/images/img.png"),
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              width: 65,
                                              height: 1,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffededed),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              widget.flightDetails['Baggage'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 65,
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Text(
                                                    widget.flightDetails[
                                                        'CarrierName'],
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                ),
                                                Text(
                                                  CommonUtils
                                                      .convertMinutesToHoursMinutes(
                                                          widget.flightDetails[
                                                              'TravelTime']),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, right: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${CommonUtils.convertToFormattedTime(widget.flightDetails['DepartureDate']).toString().toUpperCase() + '-' + CommonUtils.convertToFormattedTime(widget.flightDetails['ArrivalDate']).toString().toUpperCase()} ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      Text(
                                                        '${widget.flightDetails['StopCount']} stops',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                      if (int.parse(widget
                                                                  .flightDetails[
                                                              'StopCount']) >
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Text(
                                                            widget.flightDetails[
                                                                'ArriveCityCode'],
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 250,
                                              height: 1,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffededed),
                                                ),
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
                                                          widget.flightDetails[
                                                              'Refundable'],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /*  Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    '${widget.flightDetails['Currency']} ${widget.flightDetails['TotalPrice']}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),*/
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Stop Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: widget.flightDetails.length > 1
                            ? widget.flightDetails.length - 1
                            : 0,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            padding: EdgeInsets.all(15),
                            child: Material(
                              elevation: 15,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              widget.flightDetails[index + 1]
                                                      ['DepartCityCode']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                            Text(
                                              widget.flightDetails[index + 1]
                                                  ['DepartCityName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Image.asset(
                                          'assets/images/non_stop.jpg',
                                          height: 50,
                                        )),
                                        Column(
                                          children: [
                                            Text(
                                              widget.flightDetails[index + 1]
                                                  ['ArriveCityCode'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                            Text(
                                              widget.flightDetails[index + 1]
                                                  ['ArriveCityName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/images/img.png'),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          widget.flightDetails[
                                                                  index + 1]
                                                              ['CarrierName'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          widget.flightDetails[
                                                                  index + 1]
                                                              ['DepartureDate'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          CommonUtils.convertMinutesToHoursMinutes(
                                                              widget.flightDetails[
                                                                      index + 1]
                                                                  [
                                                                  'TotalDuration']),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${widget.flightDetails[index + 1]['StopCount']} Stops',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        '${widget.flightDetails[index + 1]['TicketAdvisory']}')
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Material(
                    elevation: 15,
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 10, left: 10, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //AdultCount
                          Text(
                            'Total Price For ${widget.flightDetails['AdultCount'] + widget.flightDetails['ChildCount'] + widget.flightDetails['InfantCount']} Persons',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              widget.flightDetails['Currency'] +
                                  widget.flightDetails['TotalPrice'],
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  widget.flightDetails['CarrierName'] +
                                      widget.flightDetails['AdultCount'] +
                                      'Adult',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 150),
                              Text(
                                widget.flightDetails['AdultBaseFare'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Adult Tax Price',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 130),
                              Text(
                                widget.flightDetails['AdultTaxFare'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 320,
                            height: 2,
                            child: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Color(0xffededed)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price You Pay',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 130),
                              Text(
                                widget.flightDetails['Currency'] +
                                    widget.flightDetails['TotalPrice'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
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
                //same error
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff74206b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Book Flight'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
    /*SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/images/img.png"),
                                width: 70,
                                height: 50,
                              ),
                              Text(widget.flightDetails['CarrierName'],
                                  textAlign: TextAlign.end,
                                  //Text(snapshot.data![index].username,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${CommonUtils.convertToFormattedTime(widget.flightDetails['DepartureDate']).toString().toUpperCase()} - ${CommonUtils.convertToFormattedTime(widget.flightDetails['ArrivalDate']).toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 95,
                                    height: 25,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange, // Button color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                      onPressed: () {
                                        */ /*   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext
                                          context) =>
                                              Reported_Dispute()));*/ /*
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle the click event here
                                          // You can navigate to a new screen, show a dialog, or perform any action you need.
                                          //print('Text Clicked!');
                                        },
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    CommonUtils.convertMinutesToHoursMinutes(
                                        widget.flightDetails['TravelTime']),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 130,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${widget.flightDetails['StopCount']} stops',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(children: [
                                Text(widget.flightDetails['DepartCityCode'],
                                    style: TextStyle(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                Icon(Icons.arrow_right_alt),
                                Text(widget.flightDetails['ArriveCityCode'],
                                    style: TextStyle(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                SizedBox(
                                  width: 150,
                                ),
                                Text(
                                  '${'BOM'}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            '2V',
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 75, left: 55),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    '30KG',
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ])),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                    'Included',
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ])),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Traveller Details',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'First Name',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: passengerNameController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date of birth',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nationality',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Document Number',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Contact Details',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'City',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Country',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    isBookingLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              submitAdivahaFlightBooking();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10.0,
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.all(10.0),
                              minimumSize: const Size(double.infinity, 50.0),
                            ),
                            child: const Text(
                              "Continue Booking",
                              style: TextStyle(fontFamily: "Montserrat"),
                            ),
                          ),
                  ],
                ),
              ),*/
  }

  @override
  void initState() {
    // TODO: implement initState
    ////print(widget.flightDetails);
    //load aaguthu ipo vera error xend panirukn hello

    //developer.log(widget.flightDetails);
    setState(() {
      // passengerNameController.text = widget.selectedPassenger.Name;
    });
    getAdivahaFlightDetails();
    super.initState();
  }
}
