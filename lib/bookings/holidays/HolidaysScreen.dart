import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Models/holidays_models.dart';
import '../../Models/passenger_ddl_model.dart';
import '../../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../flight/family_members_model.dart';
import 'holiday_detail_screen.dart';
import 'holiday_list_screen.dart';

class Holidays extends StatefulWidget {
  const Holidays({Key? key}) : super(key: key);

  @override
  _HolidaysState createState() => _HolidaysState();
}

class _HolidaysState extends State<Holidays> {
  List holidayData = [
    HolidayModel(
        title: "Alaska",
        subTitle: "516 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/5d/e9/51.jpg"),
    HolidayModel(
        title: "Agra",
        subTitle: "774 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/07/3a/67/5c.jpg"),
    HolidayModel(
        title: "Singapore",
        subTitle: "630 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/09/1f/96/ad.jpg"),
    HolidayModel(
        title: "Malaysia",
        subTitle: "2986 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6a/d6/93.jpg"),
    HolidayModel(
        title: "Dubai",
        subTitle: "3987 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/09/99/28/a3.jpg"),
    HolidayModel(
        title: "France",
        subTitle: "6243 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/fb/77/66.jpg"),
    HolidayModel(
        title: "Abu-Dhabi",
        subTitle: "399 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/90/b1/ed.jpg"),
    HolidayModel(
        title: "Australia",
        subTitle: "4167 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6f/02/29.jpg"),
    HolidayModel(
        title: "London",
        subTitle: "2727 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0e/18/b9/8a.jpg"),
    HolidayModel(
        title: "Mumbai",
        subTitle: "809 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6a/d2/67.jpg"),
    HolidayModel(
        title: "Italy",
        subTitle: "25892 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/f9/f6/a6.jpg"),
    HolidayModel(
        title: "China",
        subTitle: "11738 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/cd/f7/00.jpg"),
  ];

  var tpolicyID = '-1';
  List<PassengerDDL> passengers = [];
  List<FamilyMembersModel> passengersFamily = [];
  late PassengerDDL selectedPassenger;

  bool _isPassengersLoading = false;
  final RoundedLoadingButtonController _btnAddController =
      RoundedLoadingButtonController();
  static String _displayOptionForPassengerDDl(PassengerDDL passengerDDL) =>
      passengerDDL.Name;

  Future<void> searchBookingTravellers() async {
    var requestBody = {
      'CorporateId': '1001', // Replace with your corporate ID
      'UID': '35510b94-5342-TDemoB2C-a2e3-2e722772' // Replace with your UID
    };

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellers');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    final body = Uri(queryParameters: requestBody).query;

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      setState(() {
        _isPassengersLoading = false;
      });

      if (response.statusCode == 200) {
        List<dynamic> responseData =
            json.decode(ResponseHandler.parseData(response.body))['Table'];

        List<PassengerDDL> tmpPassengerDDL = responseData
            .where((passenger) =>
                passenger['Name'] != null &&
                passenger['Name'].toString().trim().isNotEmpty)
            .map((passenger) {
          return PassengerDDL(
            Id: passenger['Id'].toString(),
            Name: passenger['Name'],
            Age: passenger['Age'].toString(),
          );
        }).toList();

        /*List<PassengerDDL> tmpPassengerDDL = responseData.map((passenger){
          return PassengerDDL(Id: passenger['Id'].toString(), Name: passenger['Name'], Age: passenger['Age'].toString());
        }).toList();*/

        print('Size: ${tmpPassengerDDL.length}');
        setState(() {
          passengers = tmpPassengerDDL;
        });
      } else {
        print(
            'Failed to search booking travellers. Error ${response.statusCode} : ${response.body}');
        // Handle failure here
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle error here
    }
  }

  Future<void> searchDependentTravellers() async {
    var requestBody = {
      'CorporateId': '1001', // Replace with your corporate ID
      'TravellerID':
          selectedPassenger.Id, // Replace with the ID of the traveller
      'UID': '35510b94-5342-TDemoB2C-a2e3-2e722772', // Replace with your UID
    };

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellersDependant');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    final body = Uri(queryParameters: requestBody).query;

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        //print('Dependent travellers searched! Response: ${response.body}');

        List<dynamic> tmpFamilyList =
            json.decode(ResponseHandler.parseData(response.body))['Table'];

        List<FamilyMembersModel> tmpFamilyMembers = tmpFamilyList
            .map((e) => FamilyMembersModel(
                Id: e['Id'].toString(),
                Name: e['Name'],
                DOB: e['DOB'],
                Age: e['Age'].toString()))
            .toList();

        setState(() {
          passengersFamily = tmpFamilyMembers;
        });

        _btnAddController.success();

        Timer(Duration(seconds: 1), () {
          _btnAddController.reset();
        });
        // Handle success here
      } else {
        print(
            'Failed to search dependent travellers. Error ${response.statusCode} : ${response.body}');
        _btnAddController.error();
        Timer(Duration(seconds: 1), () {
          _btnAddController.reset();
        });
        // Handle failure here
      }
    } catch (error) {
      print('Error sending request: $error');
      _btnAddController.error();
      Timer(Duration(seconds: 1), () {
        _btnAddController.reset();
      });
      // Handle error here
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

            SizedBox(width: 1), // Set the desired width
            Text(
              "Holidays",
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
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Color(0xff74206b),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  color: Colors.white,
                  child: Material(
                    elevation: 5,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/images/holiday.jpg"),
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start holidays from",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Nagercoil",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "change",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      navigate(HolidayListScreen());
                                    },
                                    child: Text(
                                      "SEARCH HOLIDAY PACKAGES",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10.0,
                                      shadowColor: Color(0xff74206b),
                                      primary: Color(0xff74206b),
                                      padding: EdgeInsets.all(10.0),
                                      minimumSize: Size(150, 50.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children: List.generate(
                      holidayData.length,
                      (index) => SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.network(
                                    holidayData[index].image,
                                    fit: BoxFit.fill,
                                  )),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                width: 150,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      holidayData[index].title,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Montserrat"),
                                    ),
                                    Text(
                                      holidayData[index].subTitle,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )))),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    searchBookingTravellers();
    super.initState();
  }
}
