import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'EditJournalEntryModel.dart';

class EditJournalEntry extends StatefulWidget {
  final String Id;

  EditJournalEntry({required this.Id});

  @override
  State<EditJournalEntry> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<EditJournalEntry> {
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

  Future<List<EditJournalEntryModel>?> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<EditJournalEntryModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "JournalEntryEditById", "JournalEntryId=${widget.Id}");
    log("idddddd" + widget.Id);
    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);

      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          EditJournalEntryModel lm = EditJournalEntryModel.fromJson(list[i]);
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
                    "Edit Journal Entry",
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
              child: FutureBuilder<List<EditJournalEntryModel>?>(
                  future: getFlightTicketOrderQueue(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                        'Entry Type',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      height: 45,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data![index].serialNo,
                                            style: TextStyle(),
                                          ),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      height: 45,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data![index].referenceNo,
                                            style: TextStyle(),
                                          ),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                        'Journal Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        // Handle the calendar icon click here, e.g., open a calendar view
                                        print('Calendar icon clicked');
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  snapshot
                                                      .data![index].journalDate,
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Account Type',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                        'SubAccount Type',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                        'Super Account Type',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
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
                                        isExpanded:
                                            true, // Set this property to true
                                        underline: Container(),
                                        items: [
                                          'Option 1',
                                          'Option 2',
                                          'Option 3'
                                        ]
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
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
                                        'Amount',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      height: 45,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data![index].amount,
                                            style: TextStyle(),
                                          ),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
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
                                                    selectedValue =
                                                        value as int;
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
                                                    selectedValue =
                                                        value as int;
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      height: 160,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
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
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust the radius as needed
                                          ),
                                          primary: Colors.blue, // Button color
                                          onPrimary: Colors.white, // Text color
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust the radius as needed
                                          ),
                                          primary: Colors.red, // Button color
                                          onPrimary: Colors.white, // Text color
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
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            )));
  }
}
