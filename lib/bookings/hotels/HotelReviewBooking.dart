import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/response_handler.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart' as xml;

import '../../utils/shared_preferences.dart';
import '../flight/TravellerDetailsModel.dart';

class HotelReviewBooking extends StatefulWidget {
  final dynamic RoomDetail,
      Roomtypename,
      Roomprice,
      adultCount,
      RoomCount,
      Starcategory,
      childrenCount,
      Checkindate,
      CheckoutDate,
      hotelname,
      hoteladdress,
      hotelid,
      resultindex,
      traceid,
      roomindex,
      roomtypecode,
      imageurl,
      totaldays;
  const HotelReviewBooking(
      {super.key,
      required this.RoomDetail,
      required this.Roomtypename,
      required this.Roomprice,
      required this.adultCount,
      required this.RoomCount,
      required this.Starcategory,
      required this.childrenCount,
      required this.Checkindate,
      required this.CheckoutDate,
      required this.hotelname,
      required this.hoteladdress,
      required this.hotelid,
      required this.resultindex,
      required this.traceid,
      required this.roomindex,
      required this.roomtypecode,
      required this.imageurl,
      required this.totaldays});

  /* final dynamic hotelDetail,
      RoomDetail,
      hotelid,

      ,
      hoteladdress,
      RoomCount,
      adultCount,

      ;
  const HotelReviewBooking({
    super.key,

    required this.RoomDetail,
    required this.hotelid,


    required this.hoteladdress,




  });*/

  @override
  State<HotelReviewBooking> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelReviewBooking> {
  bool isDetailsLoading = false;
  var hotelResult = [];
  var RoomResult = [];
  int Status = 2;
  String AdultName1 = '',
      AdultTravellerId1 = '',
      AdultName2 = '',
      AdultTravellerId2 = '',
      AdultName3 = '',
      AdultTravellerId3 = '',
      AdultName4 = '',
      AdultTravellerId4 = '';
  String selectedCountryCode = '+91';
  String selectedTitleAdult1 = 'Mr';
  String selectedTitleAdult2 = 'Mr';
  String selectedTitleAdult3 = 'Mr';
  String selectedTitleAdult4 = 'Mr';
  String selectedTitleAdult5 = 'Mr';

  String selectedTitleChildren1 = 'Mr';
  String selectedTitleChildren2 = 'Mr';
  String selectedTitleChildren3 = 'Mr';
  String selectedTitleChildren4 = 'Mr';
  String selectedTitleChildren5 = 'Mr';

  String selectedTitleInfant1 = 'Mr';
  String selectedTitleInfant2 = 'Mr';
  String selectedTitleInfant3 = 'Mr';
  String selectedTitleInfant4 = 'Mr';
  String selectedTitleInfant5 = 'Mr';

  String selectedGendarAdult1 = 'Male';
  String selectedGendarAdult2 = 'Male';
  String selectedGendarAdult3 = 'Male';
  String selectedGendarAdult4 = 'Male';
  String selectedGendarAdult5 = 'Male';

  String selectedGendarChildren1 = 'Male';
  String selectedGendarChildren2 = 'Male';
  String selectedGendarChildren3 = 'Male';
  String selectedGendarChildren4 = 'Male';
  String selectedGendarChildren5 = 'Male';

  String selectedGendarInfant1 = 'Male';
  String selectedGendarInfant2 = 'Male';
  String selectedGendarInfant3 = 'Male';
  String selectedGendarInfant4 = 'Male';
  String selectedGendarInfant5 = 'Male';

  String selectedGendarContactDetail = 'Male',
      selectedGendarContactDetailAdult2 = 'Male',
      selectedGendarContactDetailAdult3 = 'Male',
      selectedGendarContactDetailAdult4 = 'Male';
  String formattedDate = '',
      formattedDate2 = '',
      formattedDate3 = '',
      formattedDate4 = '';
  TextEditingController adultLname_controller = new TextEditingController();
  TextEditingController adult2_Lname_controller = new TextEditingController();
  TextEditingController adult3_Lname_controller = new TextEditingController();
  TextEditingController adult4_Lname_controller = new TextEditingController();

  TextEditingController contactEmailController = new TextEditingController();
  TextEditingController contactMobileController = new TextEditingController();
  TextEditingController contactAddressController = new TextEditingController();
  TextEditingController contactCityController = new TextEditingController();

  var selectedDate = DateTime.now().obs;
  TextEditingController dateControllerAdult1 = TextEditingController();
  TextEditingController dateControllerAdult2 = TextEditingController();
  TextEditingController dateControllerAdult3 = TextEditingController();
  TextEditingController dateControllerAdult4 = TextEditingController();
  TextEditingController dateControllerAdult5 = TextEditingController();
  TextEditingController passengerNameController = new TextEditingController();

  TextEditingController dateControllerChildren1 = TextEditingController();
  TextEditingController dateControllerChildren2 = TextEditingController();
  TextEditingController dateControllerChildren3 = TextEditingController();
  TextEditingController dateControllerChildren4 = TextEditingController();
  TextEditingController dateControllerChildren5 = TextEditingController();

  TextEditingController dateControllerInfant1 = TextEditingController();
  TextEditingController dateControllerInfant2 = TextEditingController();
  TextEditingController dateControllerInfant3 = TextEditingController();
  TextEditingController dateControllerInfant4 = TextEditingController();
  TextEditingController dateControllerInfant5 = TextEditingController();
  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController ExpiryDateController = TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();

  TextEditingController Documentype_controllerAdult2 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult2 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult2 =
      new TextEditingController();
  TextEditingController Documentype_controllerAdult3 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult3 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult3 =
      new TextEditingController();

  TextEditingController Documentype_controllerAdult4 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult4 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult4 =
      new TextEditingController();
  Future<void> _selectDateAdult1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult1) {
      setState(() {
        dateControllerAdult1.text = DateFormat('yyyy/MM/dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult2) {
      setState(() {
        dateControllerAdult2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult3) {
      setState(() {
        dateControllerAdult3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

  @override
  void initState() {
    super.initState();
    //String ht = widget.RoomDetail.toString();
    //print("errr" + ht);
    setState(() {
      _retrieveSavedValues();
    });
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
    });
  }

  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellers?UserId=$userID&UserTypeId=$userTypeID&SearchFilter=$empName&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('userID' + userID);
    print('userTypeID' + userTypeID);
    print('empName' + empName);

    final response = await http.get(Uri.parse(url));
    print('response: ${response.statusCode}');
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<TravellerDetailsModel>(
              (data) => TravellerDetailsModel.fromJson(data))
          .toList();
    } else {
      print('Failed to load autocomplete data: ${response.statusCode}');
      throw Exception('Failed to load autocomplete data');
    }
  }

  String convertDate(String inputDate) {
    // Parse the input date string
    DateTime date = DateFormat('dd MMM yyyy').parse(inputDate);

    // Format the date in the desired format
    String formattedDate = DateFormat('yyyy/MM/dd').format(date);

    return formattedDate;
  }

  Future<void> callSecondApi(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          String _firstNameController = traveller['UDFirstName'];
          adultLname_controller.text = traveller['UDLastName'];
          dateControllerAdult1.text = traveller['UDDOB'];
          String inputDate = dateControllerAdult1.text;
          formattedDate = convertDate(inputDate);
          print("formattedDate" + formattedDate);

          print('finDate' + dateControllerAdult1.text.toString());
          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetail = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetail = "Female";
          }
          // Get data from Table1
          Documentnumber_controller.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controller.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateController.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime = DateTime.parse(ExpiryDateController.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateController.text = finDate;
          print('finDate' + ExpiryDateController.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> callSecondApiAdult2(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult2_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult2.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult2.text;
          formattedDate2 = convertDate(inputDate2);
          print("formattedDate" + formattedDate2);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult2 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult2 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult2.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controllerAdult2.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult2.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult2.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult2.text = finDate;
          print('finDate' + ExpiryDateControllerAdult2.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> callSecondApiAdult3(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult3_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult3.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult3.text;
          formattedDate3 = convertDate(inputDate2);
          print("formattedDate" + formattedDate3);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult3 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult3 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult3.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controllerAdult3.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult3.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult3.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult3.text = finDate;
          print('finDate' + ExpiryDateControllerAdult3.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> callSecondApiAdult4(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult4_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult4.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult3.text;
          formattedDate4 = convertDate(inputDate2);
          print("formattedDate" + formattedDate4);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult4 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult4 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult4.text = passportInfo['PDPassportNo'];

          Documentype_controllerAdult4.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult4.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult4.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult4.text = finDate;
          print('finDate' + ExpiryDateControllerAdult4.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> HotelRoomBooking() async {
    final Uri url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelRoomBooking');
    DateTime checkinDateTime = DateTime.parse(widget.Checkindate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);

    DateTime checkoutDateTime = DateTime.parse(widget.CheckoutDate.toString());
    String finDate1 = DateFormat('yyyy-MM-dd').format(checkoutDateTime);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'UserID': userID.toString(),
          'HotelID': widget.hotelid.toString(),
          'HotelName': widget.hotelname.toString(),
          'HotelAddress': widget.hoteladdress.toString(),
          'HotelImageUrl': widget.imageurl.toString(),
          'Nationality': 'IN',
          'Price': widget.Roomprice.toString(),
          'CheckInDate': finDate,
          'CheckOutDate': finDate1,
          'TotalDays': widget.totaldays.toString(),
          'TotAdultCount': widget.adultCount.toString(),
          'TotChildCount': '1',
          'ResultIndex': widget.resultindex.toString(),
          'TraceId': widget.traceid.toString(),
          'RoomIndex': widget.roomindex.toString(),
          'RoomTypeCode': widget.roomtypecode.toString(),
          'RoomCount': '1',
          'Room1AdultSalu1': '0',
          'Room1AdultFName1': AdultName1.toString(),
          'Room1AdultLName1': adultLname_controller.text.toString(),
          'Room1AdultLDOB1': formattedDate.toString(),
          'Room1AdultTravellerId1': AdultTravellerId1.toString(),
          'Room1AdultSalu2': '',
          'Room1AdultFName2': AdultName2.toString(),
          'Room1AdultLName2': adult2_Lname_controller.text.toString(),
          'Room1AdultLDOB2': formattedDate2.toString(),
          'Room1AdultTravellerId2': AdultTravellerId2.toString(),
          'Room1AdultSalu3': '',
          'Room1AdultFName3': '',
          'Room1AdultLName3': '',
          'Room1AdultLDOB3': '',
          'Room1AdultTravellerId3': '',
          'Room1AdultSalu4': '',
          'Room1AdultFName4': '',
          'Room1AdultLName4': '',
          'Room1AdultLDOB4': '',
          'Room1AdultTravellerId4': '',
          'Room1ChildSalu1': '0',
          'Room1ChildFName1': 'Anu',
          'Room1ChildLName1': 'lal',
          'Room1ChildLDOB1': '2016/02/16',
          'Room1ChildSalu2': '',
          'Room1ChildFName2': '',
          'Room1ChildLName2': '',
          'Room1ChildLDOB2': '',
          'Room2AdultSalu1': '',
          'Room2AdultFName1': '',
          'Room2AdultLName1': '',
          'Room2AdultLDOB1': '',
          'Room2AdultTravellerId1': '',
          'Room2AdultSalu2': '',
          'Room2AdultFName2': '',
          'Room2AdultLName2': '',
          'Room2AdultLDOB2': '',
          'Room2AdultTravellerId2': '',
          'Room2AdultSalu3': '',
          'Room2AdultFName3': '',
          'Room2AdultLName3': '',
          'Room2AdultLDOB3': '',
          'Room2AdultTravellerId3': '',
          'Room2AdultSalu4': '',
          'Room2AdultFName4': '',
          'Room2AdultLName4': '',
          'Room2AdultLDOB4': '',
          'Room2AdultTravellerId4': '',
          'Room2ChildSalu1': '',
          'Room2ChildFName1': '',
          'Room2ChildLName1': '',
          'Room2ChildLDOB1': '',
          'Room2ChildSalu2': '',
          'Room2ChildFName2': '',
          'Room2ChildLName2': '',
          'Room2ChildLDOB2': '',
          'Room3AdultSalu1': '',
          'Room3AdultFName1': '',
          'Room3AdultLName1': '',
          'Room3AdultLDOB1': '',
          'Room3AdultTravellerId1': '',
          'Room3AdultSalu2': '',
          'Room3AdultFName2': '',
          'Room3AdultLName2': '',
          'Room3AdultLDOB2': '',
          'Room3AdultTravellerId2': '',
          'Room3AdultSalu3': '',
          'Room3AdultFName3': '',
          'Room3AdultLName3': '',
          'Room3AdultLDOB3': '',
          'Room3AdultTravellerId3': '',
          'Room3AdultSalu4': '',
          'Room3AdultFName4': '',
          'Room3AdultLName4': '',
          'Room3AdultLDOB4': '',
          'Room3AdultTravellerId4': '',
          'Room3ChildSalu1': '',
          'Room3ChildFName1': '',
          'Room3ChildLName1': '',
          'Room3ChildLDOB1': '',
          'Room3ChildSalu2': '',
          'Room3ChildFName2': '',
          'Room3ChildLName2': '',
          'Room3ChildLDOB2': '',
          'Room4AdultSalu1': '',
          'Room4AdultFName1': '',
          'Room4AdultLName1': '',
          'Room4AdultLDOB1': '',
          'Room4AdultTravellerId1': '',
          'Room4AdultSalu2': '',
          'Room4AdultFName2': '',
          'Room4AdultLName2': '',
          'Room4AdultLDOB2': '',
          'Room4AdultTravellerId2': '',
          'Room4AdultSalu3': '',
          'Room4AdultFName3': '',
          'Room4AdultLName3': '',
          'Room4AdultLDOB3': '',
          'Room4AdultTravellerId3': '',
          'Room4AdultSalu4': '',
          'Room4AdultFName4': '',
          'Room4AdultLName4': '',
          'Room4AdultLDOB4': '',
          'Room4AdultTravellerId4': '',
          'Room4ChildSalu1': '',
          'Room4ChildFName1': '',
          'Room4ChildLName1': '',
          'Room4ChildLDOB1': '',
          'Room4ChildSalu2': '',
          'Room4ChildFName2': '',
          'Room4ChildLName2': '',
          'Room4ChildLDOB2': '',
          'CustomerPhone': contactMobileController.text.toString(),
          'CustomerEmail': contactEmailController.text.toString(),
        },
      );
      print('UserID: ${userID.toString()}');
      print('HotelID: ${widget.hotelid.toString()}');
      print('HotelName: ${widget.hotelname.toString()}');
      print('HotelAddress: ${widget.hoteladdress.toString()}');
      print('HotelImageUrl: ${widget.imageurl.toString()}');
      print('Nationality: IN');
      print('Price: ${widget.Roomprice.toString()}');
      print('CheckInDate: $finDate');
      print('CheckOutDate: $finDate1');
      print('TotalDays: ${widget.totaldays.toString()}');
      print('TotAdultCount: ${widget.adultCount.toString()}');
      print('TotChildCount: 1');
      print('ResultIndex: ${widget.resultindex.toString()}');
      print('TraceId: ${widget.traceid.toString()}');
      print('RoomIndex: ${widget.roomindex.toString()}');
      print('RoomTypeCode: ${widget.roomtypecode.toString()}');
      print('RoomCount: 1');
      print('Room1AdultSalu1: 0');
      print('Room1AdultFName1: ${AdultName1.toString()}');
      print('Room1AdultLName1: ${adultLname_controller.text.toString()}');
      print('Room1AdultLDOB1: ${formattedDate.toString()}');
      print('Room1AdultTravellerId1: ${AdultTravellerId1.toString()}');
      print('Room1ChildSalu1: 0');
      print('Room1ChildFName1: Anu');
      print('Room1ChildLName1: lal');
      print('Room1ChildLDOB1: 2016/02/16');
      print('CustomerPhone: ${contactMobileController.text}');
      print('CustomerEmail: ${contactEmailController.text}');

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error making POST request: $error');
    }
  }

  Future<void> _selectDateAdult4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult4) {
      setState(() {
        dateControllerAdult4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult5) {
      setState(() {
        dateControllerAdult5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren1) {
      setState(() {
        dateControllerChildren1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != ExpiryDateController) {
      setState(() {
        ExpiryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren2) {
      setState(() {
        dateControllerChildren2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren3) {
      setState(() {
        dateControllerChildren3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren4) {
      setState(() {
        dateControllerChildren4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren5) {
      setState(() {
        dateControllerChildren5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /* Future<void> getHotelDetailsByHotelID(
      String hotelID, String resultIndex, String traceId) async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetDetailsByHotelID');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = 'HotelID=$hotelID&ResultIndex=$resultIndex&TraceId=$traceId';
    print('HotelID' + hotelID);
    print('resultIndex' + resultIndex);
    print('traceId' + traceId);
    try {
      setState(() {
        isDetailsLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      setState(() {
        isDetailsLoading = false;
      });

      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful!');
        developer.log(response.body);
        var jsonResult = json.decode(ResponseHandler.parseData(response.body));
        setState(() {
          hotelResult = jsonResult;
        });
        print('hotelResult length ${hotelResult.length}');
      } else {
        // Handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }

  Future<void> getRoomDetails(
      String hotelID, String resultIndex, String traceId) async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetRoomTypesByHotelID');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = 'HotelID=$hotelID&ResultIndex=$resultIndex&TraceId=$traceId';
    print('HotelID' + hotelID);
    print('resultIndex' + resultIndex);
    print('traceId' + traceId);
    try {
      setState(() {
        isDetailsLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      setState(() {
        isDetailsLoading = false;
      });

      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful!');
        developer.log(response.body);
        var jsonResult = json.decode(ResponseHandler.parseData(response.body));
        setState(() {
          RoomResult = jsonResult;
        });
        print('RoomResult length ${RoomResult.length}');
      } else {
        // Handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }*/

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
            SizedBox(width: 1),
            Text(
              "Review Booking",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 170,
                    child: CachedNetworkImage(
                      imageUrl: widget.imageurl,
                      placeholder: (context, url) => const Center(
                          child: SizedBox(
                              height: 30,
                              width: 35,
                              child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: double.parse(widget.Starcategory
                                  .toString()), // Example rating value
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                widget.Starcategory + " " + '/5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                4), // Add some space between rating and hotel name
                        // Hotel name
                        Text(
                          widget.hotelname.toString(), // Example hotel name
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Hotel address
                        Text(
                          widget.hoteladdress.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Checkin',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    ('CheckOut'),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.Checkindate.toString().substring(0, 10),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    (widget.CheckoutDate.toString().substring(0, 10)),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.RoomCount.toString() + " " + "Room",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "" + (widget.adultCount.toString() + " " + "Adult"),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.Roomtypename.toString(),
                style: TextStyle(
                  fontSize: 17,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Text(
                    'No meals Included',
                    // Remove leading and trailing spaces
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Text(
                    'Rooms with Free Cancellation',
                    // Remove leading and trailing spaces
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Property Rules and Policies',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Text(
                    'Passport is accepted asID Proof(s)',
                    // Remove leading and trailing spaces
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Text(
                    'Pets are Not Allowed',
                    // Remove leading and trailing spaces
                    style: TextStyle(fontSize: 14),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Adult 1:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Traveller details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 'Mr',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Mr.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Radio(
                            value: 'Mrs',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Mrs.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Radio(
                            value: 'Ms',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Ms.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 160,
                              height: 50,
                              child: Autocomplete<TravellerDetailsModel>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) async {
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<
                                        TravellerDetailsModel>.empty();
                                  }
                                  return await fetchAutocompleteData(
                                      textEditingValue.text);
                                },
                                displayStringForOption:
                                    (TravellerDetailsModel option) =>
                                        '${option.name}',
                                onSelected:
                                    (TravellerDetailsModel? selectedOption) {
                                  if (selectedOption != null) {
                                    print('Selected: ${selectedOption.name}');
                                    setState(() async {
                                      await callSecondApi(selectedOption.id);
                                      AdultName1 = selectedOption.name;
                                      AdultTravellerId1 = selectedOption.id;
                                    });
                                  }
                                },
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) {
                                  return TextFormField(
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    onFieldSubmitted: (value) {
                                      onFieldSubmitted();
                                    },
                                    decoration: InputDecoration(
                                      label: const Text('First Name'),
                                      hintText: 'First Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 160,
                              height: 50,
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w500),
                                controller: adultLname_controller,
                                decoration: InputDecoration(
                                  label: const Text('SurName'),
                                  hintText: 'SurName',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
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
                              _selectDateAdult1(context);
                            },
                            controller: dateControllerAdult1,
                            style: TextStyle(fontWeight: FontWeight.w500),
                            readOnly: true,
                            decoration: InputDecoration(
                              label: const Text('DOB'),
                              hintText: 'DOB',
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  _selectDateAdult1(context);
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
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                                groupValue: selectedGendarContactDetail,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGendarContactDetail =
                                        value.toString();
                                  });
                                },
                              ),
                              Text('Male.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: 'Female',
                                groupValue: selectedGendarContactDetail,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGendarContactDetail =
                                        value.toString();
                                  });
                                },
                              ),
                              Text('Female.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: Status == 2, // Show or hide based on status
                        child: Column(
                          children: [
                            // Fields to show when status is 1
                            // Modify or add more fields as needed
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 50,
                                child: TextFormField(
                                  controller: Documentype_controller,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    label: const Text('Document Type'),
                                    hintText: 'Document Type',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
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
                                height: 50,
                                child: TextFormField(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  controller: Documentnumber_controller,
                                  decoration: InputDecoration(
                                    label: const Text('Document Number'),
                                    hintText: 'Document Number',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
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
                                height: 50,
                                child: TextField(
                                  onTap: () {
                                    _selectExpiryDate(context);
                                  },
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  controller: ExpiryDateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('Expiry Date'),
                                    hintText: 'Expiry Date',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
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
                    ],
                  ),

                  int.parse(widget.adultCount.toString()) > 1
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 9),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Adult 2:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 7),
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
                                  groupValue: selectedTitleAdult2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult2 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleAdult2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult2 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleAdult2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult2 = value.toString();
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
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: 160,
                                    height: 50,
                                    child: Autocomplete<TravellerDetailsModel>(
                                      optionsBuilder: (TextEditingValue
                                          textEditingValue) async {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<
                                              TravellerDetailsModel>.empty();
                                        }
                                        return await fetchAutocompleteData(
                                            textEditingValue.text);
                                      },
                                      displayStringForOption:
                                          (TravellerDetailsModel option) =>
                                              '${option.name}',
                                      onSelected: (TravellerDetailsModel?
                                          selectedOption) {
                                        if (selectedOption != null) {
                                          print(
                                              'Selected: ${selectedOption.name}');
                                          setState(() async {
                                            await callSecondApiAdult2(
                                                selectedOption.id);
                                            AdultName2 = selectedOption.name;
                                            AdultTravellerId2 =
                                                selectedOption.id;
                                          });
                                        }
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController
                                              textEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return TextFormField(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          controller: textEditingController,
                                          focusNode: focusNode,
                                          onFieldSubmitted: (value) {
                                            onFieldSubmitted();
                                          },
                                          decoration: InputDecoration(
                                            label: const Text('First Name'),
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
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Adjust the space between the text fields

                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: 160,
                                    height: 50,
                                    child: TextFormField(
                                      controller: adult2_Lname_controller,
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
                                    _selectDateAdult2(context);
                                  },
                                  controller: dateControllerAdult2,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateAdult2(context);
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
                                      groupValue:
                                          selectedGendarContactDetailAdult2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult2 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue:
                                          selectedGendarContactDetailAdult2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult2 =
                                              value.toString();
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
                            Visibility(
                              visible:
                                  Status == 2, // Show or hide based on status
                              child: Column(
                                children: [
                                  // Fields to show when status is 1
                                  // Modify or add more fields as needed
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextFormField(
                                        controller:
                                            Documentype_controllerAdult2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          label: const Text('Document Type'),
                                          hintText: 'Document Type',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        controller:
                                            Documentnumber_controllerAdult2,
                                        decoration: InputDecoration(
                                          label: const Text('Document Number'),
                                          hintText: 'Document Number',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextField(
                                        onTap: () {
                                          _selectExpiryDate(context);
                                        },
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        controller: ExpiryDateControllerAdult2,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          label: const Text('Expiry Date'),
                                          hintText: 'Expiry Date',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                          ],
                        )
                      : Container(),
                  int.parse(widget.adultCount.toString()) > 2
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 9),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Adult 3:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 7),
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
                                  groupValue: selectedTitleAdult3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult3 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleAdult3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult3 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleAdult3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult3 = value.toString();
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
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: 160,
                                    height: 50,
                                    child: Autocomplete<TravellerDetailsModel>(
                                      optionsBuilder: (TextEditingValue
                                          textEditingValue) async {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<
                                              TravellerDetailsModel>.empty();
                                        }
                                        return await fetchAutocompleteData(
                                            textEditingValue.text);
                                      },
                                      displayStringForOption:
                                          (TravellerDetailsModel option) =>
                                              '${option.name}',
                                      onSelected: (TravellerDetailsModel?
                                          selectedOption) {
                                        if (selectedOption != null) {
                                          print(
                                              'Selected: ${selectedOption.name}');
                                          setState(() async {
                                            await callSecondApiAdult3(
                                                selectedOption.id);
                                            AdultName3 = selectedOption.name;
                                            AdultTravellerId3 =
                                                selectedOption.id;
                                          });
                                        }
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController
                                              textEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return TextFormField(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          controller: textEditingController,
                                          focusNode: focusNode,
                                          onFieldSubmitted: (value) {
                                            onFieldSubmitted();
                                          },
                                          decoration: InputDecoration(
                                            label: const Text('First Name'),
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
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      },
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
                                      controller: adult3_Lname_controller,
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
                                    _selectDateAdult3(context);
                                  },
                                  controller: dateControllerAdult3,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateAdult3(context);
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
                                      groupValue:
                                          selectedGendarContactDetailAdult3,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult3 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue:
                                          selectedGendarContactDetailAdult3,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult3 =
                                              value.toString();
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
                            Visibility(
                              visible:
                                  Status == 2, // Show or hide based on status
                              child: Column(
                                children: [
                                  // Fields to show when status is 1
                                  // Modify or add more fields as needed
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextFormField(
                                        controller:
                                            Documentype_controllerAdult3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          label: const Text('Document Type'),
                                          hintText: 'Document Type',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        controller:
                                            Documentnumber_controllerAdult3,
                                        decoration: InputDecoration(
                                          label: const Text('Document Number'),
                                          hintText: 'Document Number',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 50,
                                      child: TextField(
                                        onTap: () {
                                          _selectExpiryDate(context);
                                        },
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        controller: ExpiryDateControllerAdult3,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          label: const Text('Expiry Date'),
                                          hintText: 'Expiry Date',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                          ],
                        )
                      : Container(),
                  int.parse(widget.adultCount.toString()) > 3
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 9),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Adult 4:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 7),
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
                                  groupValue: selectedTitleAdult4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult4 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleAdult4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult4 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleAdult4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult4 = value.toString();
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
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: 160,
                                    height: 50,
                                    child: Autocomplete<TravellerDetailsModel>(
                                      optionsBuilder: (TextEditingValue
                                          textEditingValue) async {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<
                                              TravellerDetailsModel>.empty();
                                        }
                                        return await fetchAutocompleteData(
                                            textEditingValue.text);
                                      },
                                      displayStringForOption:
                                          (TravellerDetailsModel option) =>
                                              '${option.name}',
                                      onSelected: (TravellerDetailsModel?
                                          selectedOption) {
                                        if (selectedOption != null) {
                                          print(
                                              'Selected: ${selectedOption.name}');
                                          setState(() async {
                                            await callSecondApiAdult4(
                                                selectedOption.id);
                                            AdultName4 = selectedOption.name;
                                            AdultTravellerId4 =
                                                selectedOption.id;
                                          });
                                        }
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController
                                              textEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return TextFormField(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          controller: textEditingController,
                                          focusNode: focusNode,
                                          onFieldSubmitted: (value) {
                                            onFieldSubmitted();
                                          },
                                          decoration: InputDecoration(
                                            label: const Text('First Name'),
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
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      },
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
                                      controller: adult4_Lname_controller,
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
                                    _selectDateAdult4(context);
                                  },
                                  controller: dateControllerAdult4,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateAdult4(context);
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
                                      groupValue:
                                          selectedGendarContactDetailAdult4,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult4 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue:
                                          selectedGendarContactDetailAdult4,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarContactDetailAdult4 =
                                              value.toString();
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 50,
                                child: TextFormField(
                                  controller: Documentype_controllerAdult4,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    label: const Text('Document Type'),
                                    hintText: 'Document Type',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
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
                                height: 50,
                                child: TextFormField(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  controller: Documentnumber_controllerAdult4,
                                  decoration: InputDecoration(
                                    label: const Text('Document Number'),
                                    hintText: 'Document Number',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
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
                                height: 50,
                                child: TextField(
                                  onTap: () {
                                    _selectExpiryDate(context);
                                  },
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  controller: ExpiryDateControllerAdult4,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('Expiry Date'),
                                    hintText: 'Expiry Date',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /*  Visibility(
                              visible:
                                  Status == 2,
                              child: Column(
                                children: [


                                ],
                              ),
                            ),*/
                          ],
                        )
                      : Container(),
                  int.parse(widget.adultCount.toString()) > 4
                      ? Column(
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
                                  groupValue: selectedTitleAdult5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult5 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleAdult5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult5 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleAdult5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult5 = value.toString();
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
                                    _selectDateAdult5(context);
                                  },
                                  controller: dateControllerAdult5,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateAdult5(context);
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
                                      groupValue: selectedGendarAdult5,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarAdult5 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarAdult5,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarAdult5 =
                                              value.toString();
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
                        )
                      : Container(),

                  //Children

                  int.parse(widget.childrenCount.toString()) > 0
                      ? Column(
                          children: [
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
                                  groupValue: selectedTitleChildren1,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren1 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleChildren1,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren1 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleChildren1,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren1 = value.toString();
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
                                    _selectDateChildren1(context);
                                  },
                                  controller: dateControllerChildren1,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateChildren1(context);
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
                                      groupValue: selectedGendarChildren1,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren1 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarChildren1,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren1 =
                                              value.toString();
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
                        )
                      : Container(),
                  int.parse(widget.childrenCount.toString()) > 1
                      ? Column(
                          children: [
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
                                  groupValue: selectedTitleChildren2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren2 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleChildren2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren2 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleChildren2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren2 = value.toString();
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
                                    _selectDateChildren2(context);
                                  },
                                  controller: dateControllerChildren2,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateChildren2(context);
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
                                      groupValue: selectedGendarChildren2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren2 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarChildren2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren2 =
                                              value.toString();
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
                        )
                      : Container(),
                  int.parse(widget.childrenCount.toString()) > 2
                      ? Column(
                          children: [
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
                                  groupValue: selectedTitleChildren3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren3 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleChildren3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren3 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleChildren3,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren3 = value.toString();
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
                                    _selectDateChildren3(context);
                                  },
                                  controller: dateControllerChildren3,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateChildren3(context);
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
                                      groupValue: selectedGendarChildren3,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren3 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarChildren3,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren3 =
                                              value.toString();
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
                        )
                      : Container(),
                  int.parse(widget.childrenCount.toString()) > 3
                      ? Column(
                          children: [
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
                                  groupValue: selectedTitleChildren4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren4 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleChildren4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren4 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleChildren4,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren4 = value.toString();
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
                                    _selectDateChildren4(context);
                                  },
                                  controller: dateControllerChildren4,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateChildren4(context);
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
                                      groupValue: selectedGendarChildren4,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren4 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarChildren4,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren4 =
                                              value.toString();
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
                        )
                      : Container(),
                  int.parse(widget.childrenCount.toString()) > 4
                      ? Column(
                          children: [
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
                                  groupValue: selectedTitleChildren5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren5 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Mrs',
                                  groupValue: selectedTitleChildren5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren5 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mrs.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Radio(
                                  value: 'Ms',
                                  groupValue: selectedTitleChildren5,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleChildren5 = value.toString();
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
                                    _selectDateChildren5(context);
                                  },
                                  controller: dateControllerChildren5,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: const Text('DOB'),
                                    hintText: 'DOB',
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        _selectDateChildren5(context);
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
                                      groupValue: selectedGendarChildren5,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren5 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarChildren5,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarChildren5 =
                                              value.toString();
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
                        )
                      : Container(),
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
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          width: 340,
                          height: 50,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: contactEmailController,
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              hintText: 'EMail Address',
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
                    ],
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: .1),

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
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          height: 50,
                          width: 290,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: contactMobileController,
                            decoration: InputDecoration(
                              label: const Text('Mobile Number'),
                              hintText: 'Mobile Number',
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: contactAddressController,
                        decoration: InputDecoration(
                          label: const Text('Address'),
                          hintText: 'Address',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
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
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: contactCityController,
                        decoration: InputDecoration(
                          label: const Text('City'),
                          hintText: 'City',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
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
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          label: const Text('Country'),
                          hintText: 'Country',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
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
              elevation: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
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
                          'Total Amount To Be Paid',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          Currency + " " + widget.Roomprice.toString(),
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
                ],
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Currency + " " + widget.Roomprice.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text('Inclusive of all taxes')
                        ],
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                HotelRoomBooking();
                              },
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double _getInitialRating(int starCategory) {
  if (starCategory >= 1 && starCategory <= 5) {
    return starCategory.toDouble();
  } else {
    return 1.0; // Set a default of one star if 'StarCategory' is not in the valid range
  }
}
