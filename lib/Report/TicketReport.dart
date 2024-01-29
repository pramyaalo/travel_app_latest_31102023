import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/TicketReportModel.dart';
import '../utils/response_handler.dart';

class TicketReport extends StatefulWidget {
  const TicketReport({Key? key}) : super(key: key);

  @override
  _TicketReportState createState() => _TicketReportState();
}

class _TicketReportState extends State<TicketReport> {
  static Future<List<TicketReportModel>?> getLabels() async {
    List<TicketReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "TicketReportGet",
        "SerUserTypeId=2&SerUserId=1107&UserTypeId=2&UserId=1107&StaffId=");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          TicketReportModel lm = TicketReportModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        log(error.toString());
      }
      return labelData;
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
                      "Ticket Report",
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
                backgroundColor: Colors.white),
            body: Center(
                child: FutureBuilder<List<TicketReportModel>?>(
                    future: getLabels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        elevation: 8,
                                        shadowColor: const Color(0xff9a9ce3),
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![index].Passenger,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Journey Type: ' +
                                                            snapshot
                                                                .data![index]
                                                                .JourneyType,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
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
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10.0, 5, 10, 5),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color:
                                                              Color(0xFF355E3B),
                                                          border: Border.all(
                                                            width: 0.1,
                                                            color: Colors.blue,
                                                          ),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .BookingStatus,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Class: ' +
                                                              snapshot
                                                                  .data![index]
                                                                  .ClassName,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Colors.blue,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .BookedOnDt,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Colors.blue,
                                                          ),
                                                          Text(
                                                            "Product: " +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .BookedProduct,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 230,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xffededed)),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price(Incl. Tax)",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.book_outlined,
                                                          size: 12,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Booking Id: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .BookingId,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .BookCardAmount,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))));
  }
}
