import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../utils/response_handler.dart';

class HolidayDetailScreen extends StatefulWidget {
  const HolidayDetailScreen({Key? key}) : super(key: key);

  @override
  _HolidayDetailScreenState createState() => _HolidayDetailScreenState();
}

class _HolidayDetailScreenState extends State<HolidayDetailScreen> {
  bool isLoading = false;

  var basicDetails = [];
  var subCategory = [];
  var highlights = [];
  var inclusions = [];

  String baseUrl = 'https://traveldemo.org/';
  String relativeUrl = '';

// Remove the relative path indicators (../)

// Concatenate the base URL with the corrected relative URL
  String absoluteUrl = '';

  Future<void> getHolidayDetails(String tourId) async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/HolidayGetDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = 'TourID=$tourId';

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

        var data = ResponseHandler.parseData(response.body);
        List<String> jsonStrings = data.split('|||');
        if (jsonStrings.length > 1) {
          List<List<dynamic>> jsonArrays = jsonStrings.map((jsonString) {
            List<dynamic> jsonArray = json.decode(jsonString);
            return jsonArray;
          }).toList();

          List<dynamic> firstJsonArray = jsonArrays[0];
          List<dynamic> secondJsonArray = jsonArrays[1];
          List<dynamic> thirdJsonArray = jsonArrays[2];
          List<dynamic> fourthJsonArray = jsonArrays[3];

          //print('First JSON array: $firstJsonArray');
          //print('Second JSON array: $secondJsonArray');
          developer.log(fourthJsonArray.toString());
          setState(() {
            basicDetails = firstJsonArray;

            relativeUrl = basicDetails[0]['image1'];
            relativeUrl = relativeUrl.replaceAll('../', '');
            absoluteUrl = baseUrl + relativeUrl;

            subCategory = secondJsonArray;
            highlights = fourthJsonArray;
          });
        } else {
          print('Invalid data format');
        }
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
              "Package Details",
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
          : Column(
              children: <Widget>[
                Container(
                  height: 0,
                  color: Colors.blue,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            absoluteUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xFF2f2f32)),
                                    ),
                                    Text(
                                      basicDetails[0]['Duration']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                        basicDetails[0]['TourPackage2']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(color: Colors.white))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text(basicDetails[0]['TourPackage'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text(basicDetails[0]['Description'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(basicDetails[0]['Source'],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text("2 Travellers",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text(subCategory[0]['SubCategory'],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Included in the package",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("You can fine-tune them to your liking",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: highlights.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("•",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: Text(
                                                      highlights[index]
                                                          ['Highlight'],
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color: Colors.pink,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        );
                                      }),
                                ),
                                Image(
                                    image: AssetImage(
                                        "assets/images/holidescpng.png"))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Exclusions",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                    Text(">",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.2,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Terms and Conditions",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                    Text(">",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.2,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Cancellation policy",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                    Text(">",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.2,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("After you book online",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("•",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("•",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("•",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 75,
                  color: Color(0xFF2f2f32),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("₹14,500",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text("  per person",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Book Now",
                          style: TextStyle(fontFamily: "Montserrat"),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10.0,
                          shadowColor: Colors.orange,
                          primary: Colors.orange,
                          padding: EdgeInsets.all(10.0),
                          minimumSize: Size(150, 50.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getHolidayDetails('1117');
    super.initState();
  }
}
