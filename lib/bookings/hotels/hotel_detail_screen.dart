import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/hotel_model.dart';
import '../../utils/response_handler.dart';
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
      ChildrenCountRoom4;
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
      required this.ChildrenCountRoom4});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool isLoading = false;
  var hotelResult = [];
  @override
  void initState() {
    // TODO: implement initState
    getHotelList();
    super.initState();
  }

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
      'CityId': '115936',
      'CountryCode': 'AE',
      'DefaultCurrency': 'INR',
      'CheckIn': finDate,
      'CheckOut': finDate1,
      'Rooms': widget.RoomCount,
      'AdultCountRoom1': (widget.AdultCountRoom1 != null)
          ? widget.AdultCountRoom1.toString()
          : '',
      'ChildrenCountRoom1': /* (widget.ChildrenCountRoom1 != null)
          ? widget.ChildrenCountRoom1.toString()
          : ''*/
          '1',
      'Child1AgeRoom1': '8',
      'Child2AgeRoom1': '',
      'AdultCountRoom2': /*(widget.AdultCountRoom2 != null)
          ? widget.AdultCountRoom2.toString()
          : ''*/
          '',
      'ChildrenCountRoom2': /*(widget.ChildrenCountRoom2 != null)
          ? widget.ChildrenCountRoom2.toString()
          : ''*/
          '',
      'Child1AgeRoom2': '',
      'Child2AgeRoom2': '',
      'AdultCountRoom3': /*(widget.AdultCountRoom3 != null)
          ? widget.AdultCountRoom3.toString()
          : ''*/
          '',
      'ChildrenCountRoom3': /*(widget.ChildrenCountRoom3 != null)
          ? widget.ChildrenCountRoom3.toString()
          : ''*/
          "",
      'Child1AgeRoom3': '',
      'Child2AgeRoom3': '',
      /*'AdultCountRoom4': widget.AdultCountRoom4?.toString() ?? '',
      'ChildrenCountRoom4': widget.ChildrenCountRoom4?.toString() ?? '',
      'Child1AgeRoom4': '',
      'Child2AgeRoom4': '',*/
      /* 'AdultCountRoom4': (widget.AdultCountRoom4 ?? '').toString(),
      'ChildrenCountRoom4': (widget.ChildrenCountRoom4 ?? '').toString(),
      'Child1AgeRoom4': '',
      'Child2AgeRoom4': '',*/

      // Add other parameters here as needed
    };
    print('CityId: ${'115936'}');
    print('CountryCode: ${'AE'}');
    print('DefaultCurrency: ${'INR'}');
    print('CheckIn: ${finDate}');
    print('CheckOut: ${finDate1}');
    print('Rooms: ${widget.RoomCount}');

    print('Child1AgeRoom1: ${'8'}');
    print('Child2AgeRoom1: ${''}');

    print('Child1AgeRoom2: ${''}');
    print('Child2AgeRoom2: ${''}');

    print('Child1AgeRoom3: ${' '}');
    print('Child2AgeRoom3: ${' '}');

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
    return SafeArea(
        child: Scaffold(
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
                ? Center(
                    child: CircularProgressIndicator(),
                  )
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFF870987),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.local_offer,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              Text(
                                                " Super Deals ",
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
                                        const Text(
                                          "Free Credits to spend at hotel",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          height: 200,
                                          child: CachedNetworkImage(
                                            imageUrl: hotelResult[index]
                                                ['ImageUrl'],
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child: SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child:
                                                            CircularProgressIndicator())),
                                            errorWidget:
                                                (context, url, error) =>
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
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating:
                                                        double.tryParse('5')!,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .business_center_rounded,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        color: Colors.black87,
                                                        fontSize: 12),
                                                  ),

                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Icon(
                                                    Icons.meeting_room_sharp,
                                                    size: 16,
                                                  ),
                                                  //Marquee(text: snapshot.data![index].RoomOffer, style: TextStyle(fontFamily: "Montserrat", color: Colors.black87, fontSize: 12 ),)
                                                  SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        '6',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 12),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        hotelResult[index]
                                                            ['HotelName'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            hotelResult[index]
                                                                ['Address'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 12),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xFF00AF80),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "5 / 5",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Text(
                                                        "487 ratings",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          //color: const Color(0xFFFADEE0),
                                                          color: const Color(
                                                              0xFFFADEE0),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "27% Off",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 11),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${hotelResult[index]['Currency']} ${hotelResult[index]['PricePerDay']}',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "/ night",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${hotelResult[index]['Currency']} ${hotelResult[index]['PricePerPerson']}',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        "per person",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Hotel ID: ${hotelResult[index]['ItemID']}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 0,
                                              ),
                                              Text(
                                                'Inpolicy',
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                hotelResult[index]
                                                    ['RefundString'],
                                                style: TextStyle(
                                                    color: Color(0xFF00AF80),
                                                    fontSize: 12),
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
                                  Container(
                                    color: const Color(0xFFF0FFFB),
                                    child: Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/handsanitizer.png"),
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        ),
                                        const Flexible(
                                            child: Text(
                                          "Safety & Hygiene - Self certified 90% users like property restaurant",
                                          style: TextStyle(fontSize: 12),
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          navigate(HotelDescription(
                            hotelDetail: hotelResult[index],
                          ));
                        },
                      );
                    },
                  )));
  }
}
