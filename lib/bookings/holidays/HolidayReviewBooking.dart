import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../utils/response_handler.dart';

class HolidayReviewBooking extends StatefulWidget {
  final holidayName,
      touraddress,
      CheckinDate,
      RoomCount,
      adultCount,
      Tourcode,
      featuresInclusion,
      featuresExclusion,
      price,
      modalities_rateKey,
      childrenCount;
  const HolidayReviewBooking({
    super.key,
    required this.holidayName,
    required this.touraddress,
    required this.CheckinDate,
    required this.RoomCount,
    required this.adultCount,
    required this.Tourcode,
    required this.featuresInclusion,
    required this.featuresExclusion,
    required this.price,
    required this.modalities_rateKey,
    required this.childrenCount,
  });

  @override
  State<HolidayReviewBooking> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HolidayReviewBooking> {
  bool isDetailsLoading = false;
  var hotelResult = [];
  var RoomResult = [];

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];
    for (String word in words) {
      icons.add(Row(
        children: [
          Icon(Icons.check),
          Container(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(
                word,
                style: TextStyle(color: Colors.green),
              )),
        ],
      ));
    }
    return icons;
  }

  List<Widget> createIconsForWords1(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];
    for (String word in words) {
      icons.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: Colors.red,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(
                word,
                style: TextStyle(color: Colors.red),
              )),
        ],
      ));
    }
    return icons;
  }

  var countryCodes = ['+91'];
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

  String selectedGendarContactDetail = 'Male';

  TextEditingController adultFname_controller = new TextEditingController();
  TextEditingController adultLname_controller = new TextEditingController();

  TextEditingController adult1_Fname_controller = new TextEditingController();
  TextEditingController adult1_Lname_controller = new TextEditingController();

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

  Future<void> _selectDateAdult1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult1) {
      setState(() {
        dateControllerAdult1.text = DateFormat('yyyy-MM-dd').format(picked);
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

  Future<void> bookTour() async {
    final Uri url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/TourPreconfirmBooking');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'AmountWithoutTax': widget.price,
          'TourCurrency': 'INR',
          'StayHotelName': 'stayHotelName',
          'TourRateKey': widget.modalities_rateKey,
          'FromDate': widget.CheckinDate,
          'ToDate': '2024-02-12',
          'Adult1Title': 'Mr',
          'Adult1FirstName': 'Shanthini',
          'Adult1LastName': 'Vasan',
          'Adult1DOB': '1990/01/01',
          'Address': 'MainRoad',
          'ZipCode': '629004',
          'Country': 'India',
          'Email': 'abc@abc.com',
          'Phone': '9988776655',
          'Adult2Title': '',
          'Adult2FirstName': '',
          'Adult2LastName': '',
          'Adult2DOB': '',
          'Adult3Title': '',
          'Adult3FirstName': '',
          'Adult3LastName': '',
          'Adult3DOB': '',
          'Adult4Title': '',
          'Adult4FirstName': '',
          'Adult4LastName': '',
          'Adult4DOB': '',
          'Adult5Title': '',
          'Adult5FirstName': '',
          'Adult5LastName': '',
          'Adult5DOB': '',
          'Adult6Title': '',
          'Adult6FirstName': '',
          'Adult6LastName': '',
          'Adult6DOB': '',
          'Adult7Title': '',
          'Adult7FirstName': '',
          'Adult7LastName': '',
          'Adult7DOB': '',
          'Adult8Title': '',
          'Adult8FirstName': '',
          'Adult8LastName': '',
          'Adult8DOB': '',
          'Adult9Title': '',
          'Adult9FirstName': '',
          'Adult9LastName': '',
          'Adult9DOB': '',
          'Adult10Title': '',
          'Adult10FirstName': '',
          'Adult10LastName': '',
          'Adult10DOB': '',
        },
      );

      print(response.body);
    } catch (ex) {
      print(ex);
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/hotel2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: 3, // Example rating value
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
                              SizedBox(
                                  height:
                                      4), // Add some space between rating and hotel name
                              // Hotel name
                              Text(
                                widget.holidayName
                                    .toString(), // Example hotel name
                                maxLines: 3,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              // Hotel address
                              Text(
                                widget.touraddress
                                    .toString(), // Example hotel address
                                style: TextStyle(fontSize: 14),
                              ),

                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '4' + " " + '/5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                          widget.CheckinDate.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ('-'),
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
                          " " + (widget.adultCount.toString() + " " + "Adult"),
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
                      'Tour Code : ${widget.Tourcode.toString()}',
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
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'Inclusions',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: createIconsForWords(widget.featuresInclusion),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      'Exclusions',
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
                    child: Column(
                      children: createIconsForWords1(widget.featuresExclusion),
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
                                  groupValue: selectedTitleAdult1,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitleAdult1 = value.toString();
                                    });
                                  },
                                ),
                                Text('Mr.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                                      controller: adultFname_controller,
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
                                      controller: adultLname_controller,
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
                                    _selectDateAdult1(context);
                                  },
                                  controller: dateControllerAdult1,
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
                                      groupValue: selectedGendarAdult1,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarAdult1 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text('Male.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGendarAdult1,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGendarAdult1 =
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
                        ),

                        int.parse(widget.adultCount.toString()) > 1
                            ? Column(
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
                                        groupValue: selectedTitleAdult2,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult2 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleAdult2,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult2 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleAdult2,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult2 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'Male',
                                            groupValue: selectedGendarAdult2,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult2 =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          Text('Male.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Radio(
                                            value: 'Female',
                                            groupValue: selectedGendarAdult2,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult2 =
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
                        int.parse(widget.adultCount.toString()) > 2
                            ? Column(
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
                                        groupValue: selectedTitleAdult3,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult3 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleAdult3,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult3 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleAdult3,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult3 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'Male',
                                            groupValue: selectedGendarAdult3,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult3 =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          Text('Male.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Radio(
                                            value: 'Female',
                                            groupValue: selectedGendarAdult3,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult3 =
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
                        int.parse(widget.adultCount.toString()) > 3
                            ? Column(
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
                                        groupValue: selectedTitleAdult4,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult4 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleAdult4,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult4 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleAdult4,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult4 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'Male',
                                            groupValue: selectedGendarAdult4,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult4 =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          Text('Male.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Radio(
                                            value: 'Female',
                                            groupValue: selectedGendarAdult4,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedGendarAdult4 =
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
                                            selectedTitleAdult5 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleAdult5,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult5 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleAdult5,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleAdult5 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            selectedTitleChildren1 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleChildren1,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren1 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleChildren1,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren1 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            selectedTitleChildren2 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleChildren2,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren2 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleChildren2,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren2 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            selectedTitleChildren3 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleChildren3,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren3 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleChildren3,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren3 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            selectedTitleChildren4 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleChildren4,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren4 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleChildren4,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren4 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            selectedTitleChildren5 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mr.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Mrs',
                                        groupValue: selectedTitleChildren5,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren5 =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      Text('Mrs.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Radio(
                                        value: 'Ms',
                                        groupValue: selectedTitleChildren5,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTitleChildren5 =
                                                value.toString();
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
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
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Container(
                                width: 310,
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
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            width: 310,
                            height: 50,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: contactAddressController,
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
                              textCapitalization: TextCapitalization.words,
                              controller: contactCityController,
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
                              textCapitalization: TextCapitalization.words,
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
                  Material(
                    elevation: 0,
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
                                'Total Amount To Be Paid',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'INR ${widget.price}',
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
                  )
                ],
              ),
            ),
          ),
          Material(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INR ${widget.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text('Inclusive of all taxes')
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        bookTour();
                      },
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Center(
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
