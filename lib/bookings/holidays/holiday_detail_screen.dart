import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../utils/response_handler.dart';
import '../hotels/HotelReviewBooking.dart';

class HolidayDescription extends StatefulWidget {
  final dynamic holidayList,
      RoomCount,
      adultCount,
      childrenCount,
      Checkindate,
      Tourcode,
      SightSeeingMarkup,
      defaultCurrency,
      DefaultyCurrencyvalue;

  const HolidayDescription({
    super.key,
    required this.holidayList,
    required this.RoomCount,
    required this.adultCount,
    required this.childrenCount,
    required this.Checkindate,
    required this.Tourcode,
    required this.SightSeeingMarkup,
    required this.defaultCurrency,
    required this.DefaultyCurrencyvalue,
  });

  @override
  State<HolidayDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HolidayDescription> {
  String featuresInclusion = '';
  String featuresExclusion = '';
  bool isDetailsLoading = false;
  var hotelResult = [];
  var RoomResult = [];
  Future<void> getHolidayDetails() async {
    DateTime checkinDateTime = DateTime.parse(widget.Checkindate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);
    print('finDate' + finDate);
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/TourGetDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body =
        'TourCode=${widget.Tourcode.toString()}&FromDate=${finDate.toString()}&ToDate=2024-02-12&AdultCount=${widget.adultCount.toString()}'
        '&ChildCount=${widget.childrenCount.toString()}&UserId=1107&SightSeeingMarkup=${widget.SightSeeingMarkup.toString()}'
        '&DefaultCurrency=${widget.defaultCurrency.toString()}&DefaultCurrencyValue=${widget.DefaultyCurrencyvalue.toString()}';

    setState(() {
      isDetailsLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var data = ResponseHandler.parseData(response.body);
        print(data);
        List<String> jsonStrings = data.split('|||');
        print(jsonStrings.length);
        if (jsonStrings.length > 1) {
          // Store data from the first array
          var firstArrayData = jsonStrings[0];

          // Store data from the second array
          var secondArrayData = jsonStrings[1];

          setState(() {
            var firstJsonArray = json.decode(firstArrayData);
            print(firstJsonArray);
            hotelResult = firstJsonArray;
            featuresInclusion = hotelResult[0]['featuresInclusion'].toString();
            featuresExclusion = hotelResult[0]['featuresExclusion'].toString();
            print('hotelResult');
            var secondJsonArray = json.decode(secondArrayData);
            RoomResult = secondJsonArray;
            print(secondJsonArray);
          });
        } else {
          print('Invalid data format');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
    setState(() {
      isDetailsLoading = false;
    });
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  @override
  void initState() {
    // TODO: implement initState
    getHolidayDetails();
    super.initState();
  }

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];
    for (String word in words) {
      icons.add(Row(
        children: [
          Icon(Icons.check),
          Container(
              width: 148,
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
          Icon(Icons.check),
          Container(
              width: 148,
              child: Text(
                word,
                style: TextStyle(color: Colors.red),
              )),
        ],
      ));
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> iconsForFeaturesInclusion =
        createIconsForWords(featuresInclusion);
    List<Widget> iconsForFeaturesExclusion =
        createIconsForWords1(featuresExclusion);

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
              "Hotel Description",
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
            SizedBox(
                width: double.infinity,
                height: 200,
                child: CarouselSlider(
                  items: [
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.fill,
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                  ),
                )),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelResult[0]['tourname'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    hotelResult[0]['destinationname'] +
                        "," +
                        hotelResult[0]['countryname'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Valid From',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.red)),
                      Text('Valid To',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.red))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.Checkindate.toString().substring(0, 10),
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(hotelResult[0]['Categories'].toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Guest',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.adultCount.toString() + " " + "Guests",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: Text(
                'Operationdays',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(hotelResult[0]['Operationdays'].toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: Text(
                'About Destination',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Container(
                    width: 320,
                    child: Text(
                        hotelResult[0]['content_description'].toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 15, top: 8),
              child: Text(
                'Inclusion& Exclusion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inclusions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    'Exclusions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: iconsForFeaturesInclusion,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: iconsForFeaturesExclusion,
                ),
              ],
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Modalities',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: RoomResult.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    RoomResult[index]['modalities_name'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    RoomResult[index]['durationvalue'] +
                                        RoomResult[index]['durationmetric'],
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "Cancellation Amount From" +
                                        " " +
                                        RoomResult[index]['cancelpolicyDate'] +
                                        " " +
                                        "is" +
                                        " " +
                                        RoomResult[index]
                                            ['cancelpolicypAmount'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  RoomResult[index]['modalities_rate'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.green),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /* navigate(HotelReviewBooking(
                                  hotelDetail: hotelResult[index],
                                  RoomDetail: RoomResult[index],
                                  Roomtypename: RoomTypeName,
                                  Roomprice: RoomPrice,
                                  hotelname: HotelName,
                                  hoteladdress: HotelAddress,
                                  RoomCount: widget.RoomCount,
                                  adultCount: widget.adultCount,
                                  childrenCount: widget.childrenCount,
                                  Checkindate: widget.Checkindate,

                                ));*/
                                    print('Container tapped!');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff3093c7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Center(
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
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
