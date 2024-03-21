import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/HolidayPassengerModel.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'BookingCancelScreen.dart';
import 'CancelBookingListModel.dart';
import 'PassengerModel.dart';
import 'PaymentModel.dart';

class CancellationRequestDetails extends StatefulWidget {
  final id;
  CancellationRequestDetails({super.key, required this.id});
  @override
  State<CancellationRequestDetails> createState() =>
      _CancellationRequestDetailsState();
}

class _CancellationRequestDetailsState
    extends State<CancellationRequestDetails> {
  String _userImage = '';
  String selectedAccountType = 'Select Payment Mode';

  var accountTypes = [
    'Select Payment Mode',
    'Cash',
    'Cheque',
    'Credit Cards',
    'Debit Cards',
    'Electronic Bank Transfers',
    'Mobile Payments'
  ];

  static String savedId = '';

  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table34,
      table39,
      table40,
      table20,
      table21,
      table28;
  List<BookedItemViewModel> tableData = [];
  List<PassengerModel> table2Data = [];
  List<PaymentModel> table34Data = [];
  List<CancelBookingListModel> table28Data = [];
  List<HolidayPassengerModel> table18Data = [];
  var selectedDate = DateTime.now().obs;
  TextEditingController dateController = TextEditingController();
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedId = prefs.getString('userId')!;
    });
  }

  Future<List<CancelBookingListModel>?> getLabels() async {
    List<CancelBookingListModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${widget.id}&StaffId=0");
    print('jfghhjgh' + savedId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table28"];
        print('jfghhjg1355h' + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          CancelBookingListModel lm = CancelBookingListModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        log("BCF" + error.toString());
      }
      return labelData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<CancelBookingListModel>?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                //validateTextField();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            BookingCancelScreen(
                                                                id: widget
                                                                    .id)));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black, backgroundColor: Colors
                                                    .yellow, shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Adjust the radius as needed
                                                ), // Text color
                                              ),
                                              child: SizedBox(
                                                  width: 190,
                                                  height: 43,
                                                  child: Center(
                                                    child: Text(
                                                      'Cancel Booking Request',
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                      Text(
                                        "Cancellation Requests",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: PhysicalModel(
                                          color: Colors.white,
                                          elevation: 8,
                                          shadowColor: const Color(0xff9a9ce3),
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data![index]
                                                              .requestNumber,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Request Status: " +
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .requestStatus,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
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
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10.0,
                                                                  5,
                                                                  10,
                                                                  5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orangeAccent,
                                                            border: Border.all(
                                                                width: 0.1,
                                                                color: Colors
                                                                    .blue),
                                                            //https://stackoverflow.com/a/67395539/16076689
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .request,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Image(
                                                              image: AssetImage(
                                                                  'assets/images/tickiconpng.png'),
                                                              width: 16,
                                                              color:
                                                                  Colors.blue,
                                                              height: 16,
                                                            ),
                                                            Text(
                                                              "Dep Date: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .departureDate,
                                                              style: const TextStyle(
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
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Image(
                                                              image: AssetImage(
                                                                  'assets/images/tickiconpng.png'),
                                                              width: 16,
                                                              height: 16,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            Text(
                                                              "Arr Date: " +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .arrivalDate,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 300,
                                                      height: 1,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xffededed)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.book_outlined,
                                                            size: 12,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text(
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
                                                            snapshot
                                                                .data![index]
                                                                .bookingFlightID,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
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
                                                                /* Navigator
                                                                    .push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ViewCorporateDetails(),
                                                                  ),
                                                                );*/
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        7.0,
                                                                        2.5,
                                                                        7,
                                                                        2.5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .yellow,
                                                                  border: Border.all(
                                                                      width:
                                                                          0.1,
                                                                      color: Colors
                                                                          .yellow), //https://stackoverflow.com/a/67395539/16076689
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(
                                                                          5.0),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2), // You can adjust the color and opacity
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius:
                                                                          4,
                                                                      offset: Offset(
                                                                          0,
                                                                          2), // Adjust the shadow position
                                                                    ),
                                                                  ],
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
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ]))
                          ],
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
