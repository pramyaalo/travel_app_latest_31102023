import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../utils/commonutils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;
import '../../utils/response_handler.dart';

class RoundTripBookNowFlight extends StatefulWidget {
  final flightDetails;
  const RoundTripBookNowFlight({super.key, required this.flightDetails});

  @override
  State<RoundTripBookNowFlight> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<RoundTripBookNowFlight> {
  bool isLoading = false;
  bool isBookingLoading = false;
  String selectedCountryCode = '+91';
  String selectedTitle = 'Mr';
  final FocusNode _focusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  var selectedDate = DateTime.now().obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController passengerNameController = new TextEditingController();
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

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
    List<String> countryCodes = [
      '+1',
      '+44',
      '+91',
      '+81',
      '+86',
      '+33',
      '+49',
      '+61',
      '+7',
      '+39'
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
                              //empty screen hello varutha?
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Adult 1:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Traveller details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Mr',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mr.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Mrs',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mrs.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Ms',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Ms.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      width: 135,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('FirstName'),
                                          hintText: 'First Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between the text fields

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: const Text('DOB'),
                                      hintText: 'DOB',
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          cacheWidth: 25,
                                          cacheHeight: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Male.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Female',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Female.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Adult 2:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Traveller details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Mr',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mr.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Mrs',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mrs.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Ms',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Ms.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      width: 135,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('FirstName'),
                                          hintText: 'First Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between the text fields

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: const Text('DOB'),
                                      hintText: 'DOB',
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          cacheWidth: 25,
                                          cacheHeight: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Male.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Female',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Female.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Adult 3:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Traveller details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Mr',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mr.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Mrs',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mrs.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Ms',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Ms.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      width: 135,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('FirstName'),
                                          hintText: 'First Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between the text fields

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: const Text('DOB'),
                                      hintText: 'DOB',
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          cacheWidth: 25,
                                          cacheHeight: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Male.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Female',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Female.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Adult 4:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Traveller details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Mr',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mr.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Mrs',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mrs.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Ms',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Ms.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      width: 135,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('FirstName'),
                                          hintText: 'First Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between the text fields

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: const Text('DOB'),
                                      hintText: 'DOB',
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          cacheWidth: 25,
                                          cacheHeight: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Male.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Female',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Female.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Adult 5:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Traveller details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Mr',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mr.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Mrs',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Mrs.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Ms',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Ms.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      width: 135,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('FirstName'),
                                          hintText: 'First Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between the text fields

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: const Text('DOB'),
                                      hintText: 'DOB',
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          cacheWidth: 25,
                                          cacheHeight: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Male.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Female',
                                        groupValue: selectedTitle,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitle = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Female.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Children 1:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Children 2:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Children 3:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Children 4:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Children 5:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Infant 1:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Infant 2:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Infant 3:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Infant 4:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Infant 5:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Traveller details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 'Mr',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mr.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Mrs',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Mrs.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Ms',
                                groupValue: selectedTitle,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTitle = value.toString();
                                  });
                                },
                              ),
                              Text('Ms.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 135,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('FirstName'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the space between the text fields

                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('SurName'),
                                      hintText: 'SurName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  chooseDate();
                                },
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  label: const Text('DOB'),
                                  hintText: 'DOB',
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      chooseDate();
                                    },
                                    child: Image.asset(
                                      'assets/images/calendar.png',
                                      cacheWidth: 25,
                                      cacheHeight: 25,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Contact details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 310,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('Email'),
                                      hintText: 'EMail Address',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTitle = value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10), // Adjust left margin as needed
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: .1),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  underline: SizedBox(),

                                  value: selectedCountryCode,
                                  iconSize: 0.0,
                                  // Array list of items
                                  items: countryCodes.map((String code) {
                                    return DropdownMenuItem<String>(
                                      value: code,
                                      child: Text(code),
                                    );
                                  }).toList(),

                                  onChanged: (Object? value) {
                                    setState(() {
                                      selectedCountryCode = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 260,
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text('Mobile Number'),
                                      hintText: 'Mobile Number',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  label: const Text('Address'),
                                  hintText: 'Address',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  label: const Text('City'),
                                  hintText: 'City',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  label: const Text('Country'),
                                  hintText: 'Country',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Summary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'View Full Breakup',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Base Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["BookingBaseFare"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add other pricing details or components as needed
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["BookingTax"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount To Be Paid',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["TotalPrice"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  resultFlightData[0]["Currency"] +
                                      " " +
                                      resultFlightData[0]["TotalPrice"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Add your continue button functionality here
                                  },
                                  child: Text('Continue'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.flightDetails);
    setState(() {
      getAdivahaFlightDetails();
    });

    super.initState();
  }
}
