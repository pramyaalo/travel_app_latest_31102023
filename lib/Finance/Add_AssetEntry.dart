//branchlistapi branchid=0,

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Add_AssetEntry extends StatefulWidget {
  const Add_AssetEntry({Key? key}) : super(key: key);

  @override
  State<Add_AssetEntry> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<Add_AssetEntry> {
  /*Future<List<ManageBranchModel>?> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<ManageBranchModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BranchList", "BranchId=0&Status=1&UserId=1107");

    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ManageBranchModel lm = ManageBranchModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        // Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }*/

  Future<void> saveSubAgencyId(String subAgencyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subAgencyId', subAgencyId);
  }

  int selectedValue = 1;
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
                "Add Asset Entry",
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Customer Type',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true, // Set this property to true
                          underline: Container(),
                          items: ['Option 1', 'Option 2', 'Option 3']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // Handle dropdown change
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Customer Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true, // Set this property to true
                          underline: Container(),
                          items: ['Option 1', 'Option 2', 'Option 3']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // Handle dropdown change
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Asset Name:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Asset Name',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Asset Type:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true, // Set this property to true
                          underline: Container(),
                          items: ['Option 1', 'Option 2', 'Option 3']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // Handle dropdown change
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Serial No',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Reference No',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Asset Owner',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Finance Year',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true, // Set this property to true
                          underline: Container(),
                          items: ['Option 1', 'Option 2', 'Option 3']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // Handle dropdown change
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Posting Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Purchase Invoice',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Available-for-use Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Gross Purchase Amount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Purchase Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Total Amount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(),
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                            hintText: 'Enter Recharge Amount',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Adjusted alignment
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as int;
                                    });
                                  },
                                ),
                                Text(
                                  'Active',
                                  style: TextStyle(
                                    color: selectedValue == 1
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as int;
                                    });
                                  },
                                ),
                                Text(
                                  'InActive',
                                  style: TextStyle(
                                    color: selectedValue == 2
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Notes',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        height: 160,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '  Notes',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //validateTextField();
                            /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          KYCApplication()));*/
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Adjust the radius as needed
                            ), // Text color
                          ),
                          child: SizedBox(
                              width: 115,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AddReview()));*/
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Adjust the radius as needed
                            ), // Text color
                          ),
                          child: SizedBox(
                              width: 115,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
