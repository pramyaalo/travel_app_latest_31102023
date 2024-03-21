//branchlistapi branchid=0,

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ManageTravelerModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'ViewTravellerDetails.dart';

class ManageTravellers extends StatefulWidget {
  const ManageTravellers({Key? key}) : super(key: key);

  @override
  State<ManageTravellers> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ManageTravellers> {
  static late String userTypeID;
  static late String userID;
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
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  Future<List<ManageTravelerModel>?> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<ManageTravelerModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "TravellerList", "TravellerId=0&Status=&UserId=$userID&StaffId=0");

    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ManageTravelerModel lm = ManageTravelerModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        // Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  Future<void> saveSubAgencyId(String subAgencyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subAgencyId', subAgencyId);
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
                "Travellers",
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
        body: Center(
          child: FutureBuilder<List<ManageTravelerModel>?>(
              future: getFlightTicketOrderQueue(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: SingleChildScrollView(
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: InkWell(
                                      child: PhysicalModel(
                                          color: Colors.white,
                                          elevation: 8,
                                          shadowColor: Color(0xff9a9ce3),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .udUserName,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 3),
                                                              child: Text(
                                                                "Email:  " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .udEmailId,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 0),
                                                              child: Text(
                                                                "Mobile: " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .phone,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Colors.blue,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 3),
                                                            child: Text(
                                                              "City: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .city,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 0),
                                                              child: Text(
                                                                "Gender: " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .gender,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Colors.blue,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 3),
                                                            child: Text(
                                                              "State: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .state,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 320,
                                                        height: 1,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color(
                                                                      0xffededed)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 28,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .book_outlined,
                                                                size: 14,
                                                              ),
                                                              Text(
                                                                "Traveller ID: ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .udEmployeeCode,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // Handle button press
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 4,
                                                                    left: 0,
                                                                    right: 4),
                                                            child: Container(
                                                              height: 30,
                                                              width: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _getBackgroundColor(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .isActive),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.8),
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            3),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  snapshot.data![index]
                                                                              .isActive ==
                                                                          "1"
                                                                      ? "Active"
                                                                      : "InActive",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 4,
                                                                  left: 2),
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ViewTravellerDetails(),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          5.0,
                                                                          2.5,
                                                                          5,
                                                                          2.8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.1,
                                                                        color: Colors
                                                                            .orange), //https://stackoverflow.com/a/67395539/16076689
                                                                    borderRadius:
                                                                        new BorderRadius
                                                                            .circular(
                                                                            5.0),
                                                                  ),
                                                                  child: Text(
                                                                    "View",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          )),
                                    ))));
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

Color _getBackgroundColor(String isActive) {
  if (isActive == '1') {
    return Color(0xFF16D39A);
  } else {
    return Color(0xFFFF7588);
  }
}
