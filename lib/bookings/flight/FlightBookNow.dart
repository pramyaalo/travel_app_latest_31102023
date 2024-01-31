import 'dart:convert';

import 'package:flutter/material.dart';

import '../../utils/commonutils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;
import '../../utils/response_handler.dart';

class FlightBookNow extends StatefulWidget {
  final flightDetails;
  const FlightBookNow({super.key, required this.flightDetails});

  @override
  State<FlightBookNow> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<FlightBookNow> {
  bool isLoading = false;
  bool isBookingLoading = false;

  TextEditingController passengerNameController = new TextEditingController();

  var resultFlightData = [];

  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/corporateapi.asmx/AdivahaFlightBooking');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];

    var reqBody = {
      'ResultIndex': resultIndex,
      'TraceId': traceId,
      'LCC': resultFlightData[0]['IsLCC'].toString(),
      'TripType': 'Oneway',
      'UserId': '',
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
      'AdultTravellerID1': '',
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
        //print('Request successful! Response: ${response.body}');
        developer.log(response.body);
        // Handle the response data here
      } else {
        print(
            'Request failed with status: ${response.statusCode} : ${response.body}');
        // Handle the failure scenario
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle any exceptions or errors that occurred during the request
    }
  }

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
      /*  body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child:
               Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              ),
            ),*/
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                                            resultFlightData[0]
                                                ['DepartCityCode'],
                                            style: TextStyle(
                                                color: Color(0xff777777),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
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
                                            resultFlightData[0]
                                                ['ArriveCityCode'],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  resultFlightData[0]
                                                      ['DepartCityName'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  resultFlightData[0]
                                                      ['ArriveCityName'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                                  FontWeight
                                                                      .w500,
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
                                                  decoration:
                                                      const BoxDecoration(
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
                                                          Text(
                                                            resultFlightData[0]
                                                                ['Baggage'],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 89,
                                                          ),
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
                                                                  FontWeight
                                                                      .w500,
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: resultFlightData.length > 1
                              ? resultFlightData.length - 1
                              : 0,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              padding: EdgeInsets.all(09),
                              child: Material(
                                elevation: 15,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1),
                                child: Container(
                                  padding: EdgeInsets.all(7),
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
                                                resultFlightData[index + 1]
                                                        ['DepartCityCode']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                resultFlightData[index + 1]
                                                    ['DepartCityName'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                              child: Image.asset(
                                            'assets/images/NonStop.png',
                                            height: 50,
                                          )),
                                          Column(
                                            children: [
                                              Text(
                                                resultFlightData[index + 1]
                                                    ['ArriveCityCode'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                resultFlightData[index + 1]
                                                    ['ArriveCityName'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 300,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                            color: Color(0xffededed),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, // Changed to start
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start, // Changed to start
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                        child: Text(
                                                          resultFlightData[
                                                                  index + 1]
                                                              ['CarrierName'],
                                                          textAlign:
                                                              TextAlign.end,
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
                                                                resultFlightData[
                                                                        index +
                                                                            1][
                                                                    'TravelTime']),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                right: 0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${CommonUtils.convertToFormattedTime(resultFlightData[index + 1]['DepartureDate']).toString().toUpperCase() + '-' + CommonUtils.convertToFormattedTime(widget.flightDetails['ArrivalDate']).toString().toUpperCase()} ',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 25,
                                                            ),
                                                            Text(
                                                              '${resultFlightData[index + 1]['StopCount']} stops',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14),
                                                            ),
                                                            if (int.parse(resultFlightData[
                                                                        index +
                                                                            1][
                                                                    'StopCount']) >
                                                                0)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  resultFlightData[
                                                                          index +
                                                                              1]
                                                                      [
                                                                      'ArriveCityCode'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
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
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xffededed),
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
                                                        Text(
                                                          resultFlightData[
                                                                  index + 1]
                                                              ['Baggage'],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 89,
                                                        ),
                                                        Icon(
                                                          Icons.book_outlined,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                                  index + 1]
                                                              ['Refundable'],
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
                              ),
                            );
                          })),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Personal Information',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passengerNameController,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5,
                                    left:
                                        10), // Adjust the left padding as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passengerNameController,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5,
                                    left:
                                        10), // Adjust the left padding as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passengerNameController,
                              decoration: InputDecoration(
                                hintText: 'Date Of Birth',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5,
                                    left:
                                        10), // Adjust the left padding as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passengerNameController,
                              decoration: InputDecoration(
                                hintText: 'Nationality',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5,
                                    left:
                                        10), // Adjust the left padding as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passengerNameController,
                              decoration: InputDecoration(
                                hintText: 'EMail',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5,
                                    left:
                                        10), // Adjust the left padding as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Travel Information',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 7.5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: passengerNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Visa No',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      //controller: passengerEmailController,
                                      decoration: InputDecoration(
                                        hintText: 'Exp Date',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 7.5,
                                  ),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: passengerNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Passport No',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      //controller: passengerEmailController,
                                      decoration: InputDecoration(
                                        hintText: 'Exp Date',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        isBookingLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    submitAdivahaFlightBooking();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10.0,
                                    backgroundColor: Color(0xff74206b),
                                    padding: const EdgeInsets.all(10.0),
                                    minimumSize: const Size(280, 45.0),
                                  ),
                                  child: const Text(
                                    "Continue Booking",
                                    style: TextStyle(fontFamily: "Montserrat"),
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

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.flightDetails);
    setState(() {
      //passengerNameController.text = widget.selectedPassenger.Name;
    });
    getAdivahaFlightDetails();
    super.initState();
  }
}
