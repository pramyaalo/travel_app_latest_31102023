import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/hotel_model.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'hotel_description.dart';

class HotelDetail extends StatefulWidget {
  final checkinDate,
      checkoutDate,
      RoomCount,
      AdultCountRoom1,
      ChildrenCountRoom1,
      AdultCountRoom2,
      ChildrenCountRoom2,
      AdultCountRoom3,
      ChildrenCountRoom3,
      AdultCountRoom4,
      ChildrenCountRoom4,
      cityid,
      countrycode;
  const HotelDetail(
      {super.key,
      required this.checkinDate,
      required this.checkoutDate,
      required this.RoomCount,
      required this.AdultCountRoom1,
      required this.ChildrenCountRoom1,
      required this.AdultCountRoom2,
      required this.ChildrenCountRoom2,
      required this.AdultCountRoom3,
      required this.ChildrenCountRoom3,
      required this.AdultCountRoom4,
      required this.ChildrenCountRoom4,
      required this.cityid,
      required this.countrycode});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
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
      setState(() {
        getHotelList();
      });
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
    });
  }

  bool isLoading = false;
  var hotelResult = [];

  Future<void> getHotelList() async {
    DateTime checkinDateTime = DateTime.parse(widget.checkinDate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);
    print('finDate' + finDate);
    /*  finDate = widget.checkinDate.toString().split(' ')[0];
    print(finDate);*/
    DateTime checkinDateTime1 = DateTime.parse(widget.checkoutDate.toString());
    String finDate1 = DateFormat('yyyy-MM-dd').format(checkinDateTime1);
    print('finDate' + finDate1);

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetList');

    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final requestBody = {
      'CityId': widget.cityid.toString(),
      'CountryCode': widget.countrycode.toString(),
      'APICurrencyCode': 'INR',
      'DefaultCurrency': Currency.toString(),
      'UserID': userID.toString(),
      'UserTypeID': userTypeID.toString(),
      'CheckIn': finDate,
      'CheckOut': finDate1,
      'Rooms': widget.RoomCount.toString(),
      'AdultCountRoom1': widget.AdultCountRoom1.toString(),
      'ChildrenCountRoom1': '1',
      'Child1AgeRoom1': '8',
      'Child2AgeRoom1': '',
      'AdultCountRoom2': '',
      'ChildrenCountRoom2': '',
      'Child1AgeRoom2': '',
      'Child2AgeRoom2': '',
      'AdultCountRoom3': '',
      'ChildrenCountRoom3': '',
      'Child1AgeRoom3': '',
      'Child2AgeRoom3': '',
    };
    print('CityId: ${widget.cityid.toString()}');
    print('CountryCode: ${widget.countrycode.toString()}');
    print('APICurrencyCode: INR');
    print('DefaultCurrency: ${Currency.toString()}');
    print('UserID: ${userID.toString()}');
    print('UserTypeID: ${userTypeID.toString()}');
    print('CheckIn: $finDate');
    print('CheckOut: $finDate1');
    print('Rooms: ${widget.RoomCount.toString()}');
    print('AdultCountRoom1: ${widget.AdultCountRoom1.toString()}');
    print('ChildrenCountRoom1: 1');
    print('Child1AgeRoom1: 8');
    print('Child2AgeRoom1: ');
    print('AdultCountRoom2: ');
    print('ChildrenCountRoom2:');
    print('Child1AgeRoom2: ');
    print('Child2AgeRoom2: ');
    print('AdultCountRoom3: ');
    print('ChildrenCountRoom3: ');
    print('Child1AgeRoom3: ');
    print('Child2AgeRoom3: ');

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful! Response:');
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
              SizedBox(width: 1),
              Text(
                "Hotels",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 19),
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
            : ListView.builder(
                itemCount: hotelResult.length,
                itemBuilder: (context, index) {
                  //return Text(snapshot.data?[index].LabelName ?? "got null");
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Material(
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFFAE8FA),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF870987),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.local_offer,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(
                                            (hotelResult[index]
                                                        ['StarCategory'] ==
                                                    '0')
                                                ? '1' + " " + "Star Hotel"
                                                : hotelResult[index]
                                                        ['StarCategory'] +
                                                    " " +
                                                    "Star Hotel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    RatingBar.builder(
                                      initialRating: _getInitialRating(
                                          int.parse(hotelResult[index]
                                              ['StarCategory'])),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: CachedNetworkImage(
                                        imageUrl: hotelResult[index]
                                            ['ImageUrl'],
                                        placeholder: (context, url) => const Center(
                                            child: SizedBox(
                                                height: 30,
                                                width: 35,
                                                child:
                                                    CircularProgressIndicator())),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    /*Image(
                                      //image: AssetImage('assets/images/hotel_list_1.jpg'),
                                      image: NetworkImage(snapshot.data![index].ImageUrl, ),
                                      width: 120,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ),*/

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    hotelResult[index]
                                                        ['HotelName'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    IconData(0xf053c,
                                                        fontFamily:
                                                            'MaterialIcons'),
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        hotelResult[index]
                                                            ['Address'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${hotelResult[index]['RoomCount'] + " " + "Room For"} ${hotelResult[index]['TotalDays'] + " " + "Days"}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.5),
                                              ),
                                              Text(
                                                '${Currency} ${hotelResult[index]['TotalPrice']}',
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Hotel ID: ${hotelResult[index]['ItemID']}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
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
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                hotelResult[index]
                                                    ['RefundString'],
                                                style: TextStyle(
                                                    color: Color(0xFF00AF80),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  String StarCategory =
                                                      hotelResult[index]
                                                          ['StarCategory'];
                                                  String HotelId =
                                                      hotelResult[index]
                                                          ['ItemID'];
                                                  String ResultIndex =
                                                      hotelResult[index]
                                                              ['ResultIndex']
                                                          .toString();
                                                  print('traceid:' +
                                                      hotelResult[index]
                                                              ['TraceId']
                                                          .toString());
                                                  String Hotelname =
                                                      hotelResult[index]
                                                              ['HotelName']
                                                          .toString();
                                                  String Hoteladdress =
                                                      hotelResult[index]
                                                              ['Address']
                                                          .toString();
                                                  navigate(HotelDescription(
                                                      hotelDetail:
                                                          hotelResult[index],
                                                      hotelid: HotelId,
                                                      resultindex: ResultIndex,
                                                      traceid:
                                                          hotelResult[index]
                                                                  ['TraceId']
                                                              .toString(),
                                                      Starcategory:
                                                          StarCategory,
                                                      RoomCount:
                                                          widget.RoomCount,
                                                      adultCount: widget
                                                          .AdultCountRoom1,
                                                      childrenCount: widget
                                                          .ChildrenCountRoom1,
                                                      Checkindate:
                                                          widget.checkinDate,
                                                      CheckoutDate:
                                                          widget.checkoutDate,
                                                      hotelname: Hotelname,
                                                      hoteladdress:
                                                          Hoteladdress,
                                                      imageurl:
                                                          hotelResult[index]
                                                                  ['ImageUrl']
                                                              .toString(),
                                                      totaldays:
                                                          hotelResult[index]
                                                                  ['TotalDays']
                                                              .toString()));
                                                },
                                                child: Text(
                                                  'View Details',
                                                  style: TextStyle(
                                                      color: Color(0xFF00AF80),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}

double _getInitialRating(int starCategory) {
  if (starCategory >= 1 && starCategory <= 5) {
    return starCategory.toDouble();
  } else {
    return 1.0; // Set a default of one star if 'StarCategory' is not in the valid range
  }
}
