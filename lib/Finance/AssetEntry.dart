import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/BookingReportModel.dart';
import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'Add_AssetEntry.dart';
import 'AssetEntryModel.dart';
import 'EditAssetEntry.dart';
import 'ViewAssetEntryDetails.dart';

class AssetEntry extends StatefulWidget {
  final String Id;
  AssetEntry({required this.Id});

  @override
  _BookingReportState createState() => _BookingReportState();
}

class _BookingReportState extends State<AssetEntry> {
  static late String userTypeID;
  static late String userID;
  static late String Currency;

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
      print("userTypeID" + userTypeID);
      print("userID" + userID);
      print("Curren565cy" + Currency);
    });
  }

  static Future<List<AssetEntryModel>?> getLabels() async {
    List<AssetEntryModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "AssetGet", "UserTypeId=$userTypeID&UserId=$userID&Status=-1");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          AssetEntryModel lm = AssetEntryModel.fromJson(list[i]);
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
                  "Asset Entry",
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
          child: FutureBuilder<List<AssetEntryModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 7),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      snapshot.data![index].assetName,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 2, top: 2),
                                    child: Row(
                                      children: [
                                        Icon(
                                          const IconData(0xefc6,
                                              fontFamily: 'MaterialIcons'),
                                          size: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            snapshot.data![index].assetEntry,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
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
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Date: " +
                                              snapshot
                                                  .data![index].purchaseDate,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), // Adds space between the two parts of the row
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 3),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(
                                            "Purchase Invoice: " +
                                                snapshot.data![index]
                                                    .purchaseInvoice,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
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
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Amount: " +
                                              Currency +
                                              snapshot.data![index]
                                                  .grossPurchaseAmount,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), // Adds space between the two parts of the row
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 330,
                                    height: 1,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffededed)),
                                    ),
                                  ),
                                  /*  Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  "Price(Incl. Tax)",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              )*/
                                ],
                              ),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    /*_getBackgroundColor(snapshot
                                            .data![index].bookingStatus)*/
                                                    border: Border.all(
                                                        width: 0.1,
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Text(
                                                    snapshot.data![index]
                                                                .status ==
                                                            1
                                                        ? 'Active'
                                                        : 'Inactive',
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAssetEntryDetails(
                                                    Id: snapshot.data![index]
                                                        .assetEntryId),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 5, 10, 5),
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "View",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    /*   GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditAssetEntry(),
                                          ),
                                        );
                                        //EditAssetEntry
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 5, 10, 5),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "Edit",
                                                //snapshot.data![index].bookingStatus,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),*/
                                    /*   Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    "800",
                                    //snapshot.data![index].totalAmount,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

/*
body: Center(
child: FutureBuilder<List<BookingReportModel>?>(
future: Future.delayed(0.0 as Duration) ,
builder: (context, snapshot) {
if (snapshot.hasData &&
snapshot.connectionState == ConnectionState.done) {
return ListView.builder(
itemCount: snapshot.data!.length,
itemBuilder: (context, index) {
return Container(
child: SingleChildScrollView(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Column(children: [
Card(
margin: const EdgeInsets.only(
right: 10, left: 10, top: 7),
elevation: 5,
color: Colors.white,
child: Column(
children: [
Row(
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Padding(
padding:
const EdgeInsets.only(
left: 10, top: 10),
child: Text(
snapshot
    .data![index].passenger,
style: TextStyle(
fontFamily: "Montserrat",
fontSize: 17,
fontWeight:
FontWeight.bold,
),
),
),
Padding(
padding:
const EdgeInsets.only(
right: 5, top: 10),
child: Text(
"Trip Date: " +
snapshot.data![index]
    .tripDate,
style: TextStyle(
fontFamily: "Montserrat",
fontSize: 15,
fontWeight:
FontWeight.w500,
),
),
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
const EdgeInsets.only(
left: 10),
child: Row(
children: [
Icon(
const IconData(0xefc6,
fontFamily:
'MaterialIcons'),
size: 15,
),
Padding(
padding:
const EdgeInsets
    .only(right: 0),
child: Text(
"Product: " +
snapshot
    .data![index]
    .bookedProduct,
style: TextStyle(
fontFamily:
"Montserrat",
fontWeight:
FontWeight.w500,
fontSize: 15,
),
),
),
],
),
),
Spacer(), // Adds space between the two parts of the row
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
const EdgeInsets.only(
right: 5),
child: Text(
"Paid Status: " +
snapshot
    .data![index]
    .paidStatus,
style: TextStyle(
fontFamily:
"Montserrat",
fontWeight:
FontWeight.w500,
fontSize: 15,
color: Colors.blue,
),
),
),
],
),
],
),
SizedBox(
height: 3,
),
Row(
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Padding(
padding:
const EdgeInsets.only(
left: 10),
child: Row(
children: [
Container(
padding:
EdgeInsets.fromLTRB(
10.0, 5, 10, 5),
decoration:
BoxDecoration(
color: _getBackgroundColor(
snapshot
    .data![index]
    .bookingStatus),
border: Border.all(
width: 0.1,
color:
Colors.blue),
borderRadius:
BorderRadius
    .circular(
5.0),
),
child: Text(
snapshot.data![index]
    .bookingStatus,
style: TextStyle(
fontFamily:
"Montserrat",
fontSize: 15,
fontWeight:
FontWeight.w500,
color: Colors.white,
),
),
),
],
),
),
Padding(
padding:
const EdgeInsets.only(
right: 5),
child: Row(
crossAxisAlignment:
CrossAxisAlignment
    .end,
children: [
Row(
children: [
Padding(
padding:
const EdgeInsets
    .only(
bottom:
15),
child: Image(
image: AssetImage(
'assets/images/tickiconpng.png'),
color: Colors
    .blue,
width: 16,
height: 16,
),
),
Padding(
padding:
const EdgeInsets
    .only(
bottom:
15),
child: Text(
snapshot
    .data![
index]
    .bookedOnDt,
style:
TextStyle(
fontFamily:
"Montserrat",
fontWeight:
FontWeight
    .w500,
fontSize:
14,
color: Colors
    .blue,
),
),
),
],
),
])),
],
),
Row(
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
SizedBox(
width: 250,
height: 1,
child: DecoratedBox(
decoration:
const BoxDecoration(
color: Color(
0xffededed)),
),
),
Padding(
padding:
const EdgeInsets.only(
right: 4),
child: Text(
"Price(Incl. Tax)",
style: TextStyle(
fontFamily:
"Montserrat",
fontSize: 12,
fontWeight:
FontWeight.w500),
),
)
],
),
Container(
height: 35,
child: Row(
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Padding(
padding:
const EdgeInsets.only(
left: 10),
child: Row(
mainAxisAlignment:
MainAxisAlignment
    .center,
children: [
Icon(
Icons.book_outlined,
size: 14,
),
Text(
"Booking ID: ",
style: TextStyle(
fontFamily:
"Montserrat",
fontWeight:
FontWeight
    .w500,
fontSize: 15),
),
Text(
snapshot.data![index]
    .bookingId,
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
),
Padding(
padding:
const EdgeInsets.only(
right: 4),
child: Text(
snapshot.data![index]
    .totalAmount,
style: TextStyle(
fontFamily:
"Montserrat",
fontSize: 18,
fontWeight:
FontWeight.bold),
),
)
],
),
)
],
),
),
]),
])));
});
} else {
return CircularProgressIndicator();
}
}))));*/
Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'TicketIssued') {
    return Color(0xFF16D39A);
  } else if (bookingStatus == 'Processing') {
    return Color(0xFFFF66CC);
  } else if (bookingStatus == 'Cancelled') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Confirmed') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else {
    return Colors.black;
  }
}
