import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../utils/response_handler.dart';
import 'holiday_detail_screen.dart';

class HolidayListScreen extends StatefulWidget {
  const HolidayListScreen({super.key});

  @override
  State<HolidayListScreen> createState() => _HolidayListScreenState();
}

class _HolidayListScreenState extends State<HolidayListScreen> {
  bool isLoading = false;

  var holidaysList = [];

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  Future<void> getHolidayList(String destinationName, String holidayDate,
      String defaultCurrency) async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/HolidayGetList');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body =
        'DestinationName=$destinationName&HolidayDate=$holidayDate&DefaultCurrency=$defaultCurrency';

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
        // Handle the successful response here
        //print('Request successful! Response: ${response.body}');

        String parsedJsonString = ResponseHandler.parseData(response.body);
        //developer.log(parsedJsonString);
        setState(() {
          holidaysList = json.decode(parsedJsonString);
        });

        developer.log('holidaysList.length : ${holidaysList.length}');
      } else {
        // Handle the failure scenario
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            size: 35, weight: 800.0, color: Theme.of(context).primaryColor),
        //titleSpacing: 0,
        title: const Text(
          "Holidays",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: holidaysList.length,
              itemBuilder: (BuildContext context, index) {
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 220,
                                    child: CachedNetworkImage(
                                      imageUrl: holidaysList[index]['ImgUrl'],
                                      placeholder: (context, url) => const Center(
                                          child: SizedBox(
                                              height: 40,
                                              width: 40,
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
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating: double.tryParse(
                                                  holidaysList[index]
                                                      ['StarCategory'])!,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 15,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
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
                                              Icons.business_center_rounded,
                                              size: 16,
                                            ),
                                            Text(
                                              '0',
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: const TextStyle(
                                                      fontFamily: "Montserrat",
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
                                                  holidaysList[index]['Title'],
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
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      holidaysList[index]
                                                          ['Country'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 45,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        const Color(0xFF00AF80),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${holidaysList[index]['StarCategory']} /5',
                                                      style: const TextStyle(
                                                          color: Colors.white,
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
                                                      fontFamily: "Montserrat",
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
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //color: const Color(0xFFFADEE0),
                                                    color:
                                                        const Color(0xFFFADEE0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${holidaysList[index]['Currency']} ${holidaysList[index]['Price']}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  " / Adult",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tour ID: ${holidaysList[index]['TourID']}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
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
                                                  'Active',
                                                  style: TextStyle(
                                                      color: Color(0xFF00AF80),
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: Center(
                                                child: Text(
                                                  'Book Now',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
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
                            Container(
                              color: const Color(0xFFFAE8FA),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/handsanitizer.png"),
                                        width: 30,
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  Flexible(
                                      child: Text(
                                    holidaysList[index]['Description'],
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                    navigate(HolidayDetailScreen());
                  },
                );
              }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getHolidayList('Dubai', '2024/01/02', 'INR');
    super.initState();
  }
}
