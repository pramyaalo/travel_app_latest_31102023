import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/HolidayPassengerModel.dart';
import '../Models/HotelPassengerModel.dart';
import '../utils/response_handler.dart';
import 'AllocatePaymentScreen.dart';
import 'BalancePaymentTransactionModel.dart';
import 'BookedItemViewModel.dart';
import 'CarAgentModel.dart';
import 'CarPassengerModel.dart';
import 'ContactAgentDetailModel.dart';
import 'HotelAgentModel.dart';
import 'PartPaymentTransactionModel.dart';
import 'PassengerModel.dart';
import 'ReceivedPaymentModel.dart';
import 'RefundPaymentModel.dart';

class PaymentTransactions extends StatefulWidget {
  final id;
  PaymentTransactions({super.key, required this.id});
  @override
  State<PaymentTransactions> createState() => _PaymentTransactionsState();
}

class _PaymentTransactionsState extends State<PaymentTransactions> {
  static String savedId = '';
  String? savedName;
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
      table32,
      table33,
      table34,
      table35,
      table39,
      table40,
      table20,
      table21;
  List<BookedItemViewModel> tableData = [];
  List<PassengerModel> table2Data = [];
  List<ContactAgentDetailModel> table5Data = [];
  List<HotelPassengerModel> table8Data = [];
  List<HotelAgentModel> table10Data = [];
  List<CarPassengerModel> table13Data = [];
  List<HolidayPassengerModel> table18Data = [];
  List<ReceivedPaymentModel> table32Data = [];
  List<PartPaymentTransactionModel> table33Data = [];
  List<BalancePaymentTransactionModel> table34Data = [];
  List<RefundPaymentModel> table35Data = [];
  //table35
  List<CarAgentModel> table20Data = [];
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

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${widget.id}&StaffId=0");
    print('jfghhjgh' + savedId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table2 = map["Table2"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table32 = map['Table32'];
      table33 = map['Table33'];
      table34 = map['Table34'];
      table35 = map['Table35'];
      table18 = map['Table18'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  if (table0.isNotEmpty) {
                    BookedItemViewModel m0 =
                        BookedItemViewModel.fromJson(table0[0]);
                    for (int i = 0; i < table0.length; i++) {
                      BookedItemViewModel t1Data =
                          BookedItemViewModel.fromJson(table0[i]);
                      tableData.add(t1Data);
                      print(
                          'Index: $i, Table4 Length: ${table0.length}, t1Data: $t1Data');
                    }
                  }
                  table2Data.clear();
                  if (table2.isNotEmpty) {
                    PassengerModel m2 = PassengerModel.fromJson(table2[0]);
                    for (int i = 0; i < table2.length; i++) {
                      PassengerModel t2Data =
                          PassengerModel.fromJson(table2[i]);
                      table2Data.add(t2Data);
                      print(
                          'Index: $i, Table4 Length: ${table2.length}, t1Data: $t2Data');
                    }
                  }

                  table5Data.clear();
                  if (table5.isNotEmpty) {
                    ContactAgentDetailModel m5 =
                        ContactAgentDetailModel.fromJson(table5[0]);
                    for (int i = 0; i < table5.length; i++) {
                      ContactAgentDetailModel t2Data =
                          ContactAgentDetailModel.fromJson(table5[i]);
                      table5Data.add(t2Data);
                      print(
                          'Index: $i, table5 Length: ${table5.length}, t1Data: $t2Data');
                    }
                  }
                  table8Data.clear();
                  if (table8.isNotEmpty) {
                    HotelPassengerModel m8 =
                        HotelPassengerModel.fromJson(table8[0]);
                    for (int i = 0; i < table8.length; i++) {
                      HotelPassengerModel t8Data =
                          HotelPassengerModel.fromJson(table8[i]);
                      table8Data.add(t8Data);
                      print(
                          'Index: $i, Table8 Length: ${table8.length}, t1Data: $t8Data');
                    }
                  }
                  table10Data.clear();
                  if (table10.isNotEmpty) {
                    HotelAgentModel m10 = HotelAgentModel.fromJson(table10[0]);
                    for (int i = 0; i < table10.length; i++) {
                      HotelAgentModel t9Data =
                          HotelAgentModel.fromJson(table10[i]);
                      table10Data.add(t9Data);
                      print(
                          'Index: $i, Table6 Length: ${table10.length}, t1Data: $t9Data');
                    }
                  }
                  table13Data.clear();
                  if (table13.isNotEmpty) {
                    CarPassengerModel m16 =
                        CarPassengerModel.fromJson(table13[0]);

                    for (int i = 0; i < table13.length; i++) {
                      CarPassengerModel t13Data =
                          CarPassengerModel.fromJson(table13[i]);
                      table13Data.add(t13Data);
                      print(
                          'Index: $i, Table12 Length: ${table13.length}, t1Data: $t13Data');
                    }
                  }
                  table18Data.clear();
                  if (table18.isNotEmpty) {
                    HolidayPassengerModel m16 =
                        HolidayPassengerModel.fromJson(table18[0]);

                    for (int i = 0; i < table18.length; i++) {
                      HolidayPassengerModel t18Data =
                          HolidayPassengerModel.fromJson(table18[i]);
                      table18Data.add(t18Data);
                      print(
                          'Index: $i, Table16 Length: ${table18.length}, t1Data: $t18Data');
                    }
                  }
                  table20Data.clear();
                  if (table20.isNotEmpty) {
                    CarAgentModel m16 = CarAgentModel.fromJson(table20[0]);

                    for (int i = 0; i < table20.length; i++) {
                      CarAgentModel t20Data =
                          CarAgentModel.fromJson(table20[i]);
                      table20Data.add(t20Data);
                      print(
                          'Index: $i, Table12 Length: ${table20.length}, t1Data: $t20Data');
                    }
                  }
                  table32Data.clear();
                  if (table32.isNotEmpty) {
                    ReceivedPaymentModel m16 =
                        ReceivedPaymentModel.fromJson(table32[0]);

                    for (int i = 0; i < table32.length; i++) {
                      ReceivedPaymentModel t20Data =
                          ReceivedPaymentModel.fromJson(table32[i]);
                      table32Data.add(t20Data);
                    }
                    print('Table32 Length: ${table32.length} ');
                  }
                  table33Data.clear();
                  if (table33.isNotEmpty) {
                    PartPaymentTransactionModel m16 =
                        PartPaymentTransactionModel.fromJson(table33[0]);

                    for (int i = 0; i < table33.length; i++) {
                      PartPaymentTransactionModel t20Data =
                          PartPaymentTransactionModel.fromJson(table33[i]);
                      table33Data.add(t20Data);
                    }
                    print('Table32 Length: ${table33.length} ');
                  }
                  table34Data.clear();
                  if (table34.isNotEmpty) {
                    BalancePaymentTransactionModel m16 =
                        BalancePaymentTransactionModel.fromJson(table34[0]);

                    for (int i = 0; i < table34.length; i++) {
                      BalancePaymentTransactionModel t20Data =
                          BalancePaymentTransactionModel.fromJson(table34[i]);
                      table34Data.add(t20Data);
                    }
                    print('Table32 Length: ${table34.length} ');
                  }
                  table35Data.clear();
                  if (table35.isNotEmpty) {
                    RefundPaymentModel m16 =
                        RefundPaymentModel.fromJson(table35[0]);

                    for (int i = 0; i < table35.length; i++) {
                      RefundPaymentModel t20Data =
                          RefundPaymentModel.fromJson(table35[i]);
                      table35Data.add(t20Data);
                    }
                    print('Table32 Length: ${table35.length} ');
                  }
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AllocatePaymentScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                                    side: BorderSide(
                                        color: Colors.yellow, width: 1),
                                    minimumSize: Size(150, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4)) // Adjust the size as needed
                                    ),
                                child: Text('Allocate Payment',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed logic here
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                                    side: BorderSide(
                                        color: Colors.yellow, width: 1),
                                    minimumSize: Size(150, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4)) // Adjust the size as needed
                                    ),
                                child: Text('Refund Payment',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          Text(
                            "Received Transaction",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              children: List.generate(
                                  table32Data.length,
                                  (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Paid By: ' +
                                                        "${table32Data[index].paidBy}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Received Date: ' +
                                                        "${table32Data[index].createdDate}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Received Amount: ' +
                                                        "${table32Data[index].allocatedAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Balance Amount: ' +
                                                        "${table32Data[index].balanceAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Pay Mode: ' +
                                                        "${table32Data[index].paymentMode}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                        ],
                                      )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 5,
                            height: 0.2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Part Payment Transaction",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: table33Data.length > 0
                                ? Column(
                                    children: List.generate(
                                        table33Data.length,
                                        (index) => Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          top: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Paid By: ' +
                                                              "${table33Data[index].paidBy}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          top: 4),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          'Part Payment Date: ' +
                                                              "${table33Data[index].createdDate}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          top: 4),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          'Paid Amount: ' +
                                                              "${table33Data[index].allocatedAmount}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          top: 4),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          'Payment Mode: ' +
                                                              "${table33Data[index].paymentMode}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 9,
                                                ),
                                              ],
                                            )),
                                  )
                                : Text(
                                    'No data Found',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 5,
                            height: 0.2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Balance Payment Transaction",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              children: List.generate(
                                  table34Data.length,
                                  (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Booking ID: ' +
                                                        "${table34Data[index].cpBookFlightId}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Booking Amount: ' +
                                                        "${table34Data[index].bookingAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Paid Amount: ' +
                                                        "${table34Data[index].allocatedAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Balance Amount: ' +
                                                        "${table34Data[index].balanceAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                        ],
                                      )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 5,
                            height: 0.2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Refund Transaction",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              children: List.generate(
                                  table35Data.length,
                                  (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Company: ' + "Travel Demo",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Booking Amount: ' +
                                                        "${table35Data[index].bookingAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Paid Amount: ' +
                                                        "${table35Data[index].allocatedAmount}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Refund Amount: ' +
                                                        "${table35Data[index].totalRefund}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Refund Status: ' +
                                                        "${table35Data[index].refundStatus}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                        ],
                                      )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 5,
                            height: 0.2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                } catch (error) {
                  print('Unexpected error: $error');
                  return Text('An unexpected error occurred.');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
