import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../../utils/response_handler.dart';

class HotelReviewBooking extends StatefulWidget {
  final dynamic hotelDetail,
      RoomDetail,
      Roomtypename,
      hotelname,
      hoteladdress,
      Starcategory,
      RoomCount,
      adultCount,
      childrenCount,
      Checkindate,
      CheckoutDate;
  const HotelReviewBooking(
      {super.key,
      required this.hotelDetail,
      required this.RoomDetail,
      required this.Roomtypename,
      required this.hotelname,
      required this.hoteladdress,
      required this.Starcategory,
      required this.RoomCount,
      required this.childrenCount,
      required this.adultCount,
      required this.Checkindate,
      required this.CheckoutDate});

  @override
  State<HotelReviewBooking> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelReviewBooking> {
  bool isDetailsLoading = false;
  var hotelResult = [];
  var RoomResult = [];

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
  void initState() {
    // TODO: implement initState

    super.initState();
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
                        SizedBox(
                            height:
                                4), // Add some space between hotel name and address
                        // Hotel address
                        Text(
                          widget.hoteladdress
                              .toString(), // Example hotel address
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                          "TotalPrice",
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
                          "TotalPrice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // submitAdivahaFlightBooking();
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
