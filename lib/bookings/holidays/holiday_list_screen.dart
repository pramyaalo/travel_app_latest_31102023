import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;

import '../../utils/shared_preferences.dart';
import 'holiday_detail_screen.dart';

class HolidayListScreen extends StatefulWidget {
  final checkinDate,
      RoomCount,
      AdultCountRoom1,
      ChildrenCountRoom1,
      AdultCountRoom2,
      ChildrenCountRoom2,
      AdultCountRoom3,
      ChildrenCountRoom3,
      AdultCountRoom4,
      ChildrenCountRoom4,
      Locationid;
  const HolidayListScreen(
      {super.key,
      required this.checkinDate,
      required this.RoomCount,
      required this.AdultCountRoom1,
      required this.ChildrenCountRoom1,
      required this.AdultCountRoom2,
      required this.ChildrenCountRoom2,
      required this.AdultCountRoom3,
      required this.ChildrenCountRoom3,
      required this.AdultCountRoom4,
      required this.ChildrenCountRoom4,
      required this.Locationid});

  @override
  State<HolidayListScreen> createState() => _HolidayListNewState();
}

class _HolidayListNewState extends State<HolidayListScreen> {
  bool isLoading = false;

  var holidayList = [];
  String featuresInclusion = '';
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
      fetchTourList();
    });
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

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  Future<void> fetchTourList() async {
    String fin_date =
        widget.checkinDate.toString().split(' ')[0].replaceAll('/', '-');
    print('fin_date' + fin_date);
    final url =
        Uri.parse('https://traveldemo.org/travelapp/b2capi.asmx/TourGetList');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'DestinationName': widget.Locationid,
      'FromDate': fin_date,
      'ToDate': fin_date,
      'AdultCount': widget.AdultCountRoom1.toString(),
      'ChildCount': widget.ChildrenCountRoom1.toString(),
      'DefaultCurrency': Currency.toString(),
      'UserId': userID.toString(),
    };
    print('Destination Name: ${widget.Locationid.toString()}');
    print('From Date: ${fin_date.toString()}');
    print('To Date: $fin_date');
    print('Adult Count: ${widget.AdultCountRoom1.toString()}');
    print('Child Count: ${widget.ChildrenCountRoom1.toString()}');
    print('Default Currency: ${Currency.toString()}');
    print('User ID: ${userID.toString()}');
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response data
        //print('Response: ${response.body}');
        setState(() {
          holidayList = extractJsonFromXml(response.body).toList();
          featuresInclusion = holidayList[0]['featuresInclusion'].toString();
          print('featuresInchjtlusion' + featuresInclusion);
          print('holidayList length: ');
          print(holidayList.length);
        });
      } else {
        // Request failed, handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split("||");
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

  @override
  Widget build(BuildContext context) {
    List<Widget> iconsForFeaturesInclusion =
        createIconsForWords(featuresInclusion);
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
                "Holiday List",
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
                itemCount: holidayList.length,
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
                                            (holidayList[index]
                                                    ['durationvalue'] +
                                                holidayList[index]
                                                    ['durationmetric']),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Duration',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    ),
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
                                      width: 110,
                                      height: 180,
                                      child: CachedNetworkImage(
                                        imageUrl: holidayList[index]['imgUrl'],
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
                                                    holidayList[index]['name'],
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
                                                height: 3,
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
                                                        holidayList[index]
                                                            ['countryname'],
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
                                            height: 3,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${holidayList[index]['currency']} ${holidayList[index]['amount']}',
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  '${holidayList[index]['featuresInclusion']}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
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
                                                'Code: ${holidayList[index]['code']}',
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
                                                holidayList[index]
                                                    ['activityFactsheetType'],
                                                style: TextStyle(
                                                    color: Color(0xFF00AF80),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  String TourCode =
                                                      holidayList[index]['code']
                                                          .toString();
                                                  String SightSeeingMarkup =
                                                      holidayList[index][
                                                              'sightSeeingMarkup']
                                                          .toString();
                                                  String defaultCurrency =
                                                      holidayList[index][
                                                              'defaultCurrency']
                                                          .toString();
                                                  String DefaultyCurrencyvalue =
                                                      holidayList[index][
                                                              'defaultCurrencyvalue']
                                                          .toString();
                                                  navigate(HolidayDescription(
                                                    holidayList:
                                                        holidayList[index],
                                                    Tourcode: TourCode,
                                                    SightSeeingMarkup:
                                                        SightSeeingMarkup,
                                                    defaultCurrency:
                                                        defaultCurrency,
                                                    DefaultyCurrencyvalue:
                                                        DefaultyCurrencyvalue,
                                                    RoomCount: widget.RoomCount,
                                                    adultCount:
                                                        widget.AdultCountRoom1,
                                                    childrenCount: widget
                                                        .ChildrenCountRoom1,
                                                    Checkindate:
                                                        widget.checkinDate,
                                                    imageUrl: holidayList[index]
                                                        ['imgUrl'],
                                                  ));
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
