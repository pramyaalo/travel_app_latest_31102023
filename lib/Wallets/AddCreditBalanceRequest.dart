import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

class AddCreditBalanceRequest extends StatefulWidget {
  const AddCreditBalanceRequest({Key? key}) : super(key: key);

  @override
  State<AddCreditBalanceRequest> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<AddCreditBalanceRequest> {
  final TextEditingController DepositAmountController = TextEditingController();
  final TextEditingController _TransactionNumber = TextEditingController();
  final TextEditingController AccountNumber = TextEditingController();
  final TextEditingController IssuedBankName = TextEditingController();
  final TextEditingController IssuedBanchName = TextEditingController();
  final TextEditingController Remarks = TextEditingController();
  static late String userTypeID;
  static late String userID;
  static late String Currency;
  String formattedDate = '';
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        print("selectedDate" + formattedDate.toString());
      });
    }
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

  String displayText = 'Customer (CUS)';
  String PaymentMode = 'All';
  int selectedOption = 1;
  List<String> options = ['Website', 'Bank'];
  String PaymentType = 'Select Payment Type';
  String AuthorizedBy = 'Select Authorized By';

  Future<http.Response>? __futureLogin;
  DateTime? checkInDate;

  Future<void> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
  }
  /* static Future<List<CreditBalanceApprovaalModel>?> getLabels() async {
    List<CreditBalanceApprovaalModel> labelData = [];
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "CreditBalanceApprovalGet", "UserId=0&UserTypeId=2&TransactionNo=0");

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log('hjgfhjyfgjhyg' + jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CreditBalanceApprovaalModel lm =
              CreditBalanceApprovaalModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {}
      return labelData;
    });
  }*/

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
              "Add Credit Balance",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 17),
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
                      left: 5,
                      right: 5,
                    ),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true, // Set this property to true
                        underline: Container(),
                        value: displayText,
                        items: [
                          'Customer (CUS)',
                          'Traveller (TVR)',
                          // Add more options here if needed
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle dropdown change
                          setState(() {
                            displayText = value!;
                          });
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
                      left: 5,
                      right: 5,
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
                        'Payment Mode:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true, // Set this property to true
                        underline: Container(),
                        value: PaymentMode,
                        items: [
                          'All',
                          'Bank',
                          'Online',
                          // Add more options here if needed
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle dropdown change
                          setState(() {
                            PaymentMode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Payment Type:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true, // Set this property to true
                        underline: Container(),
                        value: PaymentType,
                        items: [
                          'Select Payment Type',
                          'Cash',
                          'Cheque',
                          'Credit Cards',
                          'Debit Cards',
                          'Electronic Bank transfers',
                          'Mobile Payments',
                          // Add more options here if needed
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle dropdown change
                          setState(() {
                            PaymentType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Deposit Amount:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: DepositAmountController,
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
                          hintText: 'Enter Deposit Amount',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Authorized By:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 10),
                    child: Container(
                      height: 45, width: 320,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<int>(
                        isExpanded: true, // Set this property to true
                        underline: Container(),
                        value: selectedOption,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedOption = newValue!;
                            print(selectedOption);
                          });
                        },
                        items: options.map((String option) {
                          return DropdownMenuItem<int>(
                            value: options.indexOf(option) + 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(option),
                            ),
                          );
                        }).toList(),
                      ),

                      // Dropdown icon
                    ),
                  ),
                  SizedBox(height: 10),
                  if (selectedOption == 1) // Website option selected

                    if (selectedOption == 2) // Bank option selected

                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Transaction Number:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _TransactionNumber,
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
                          hintText: 'Enter Transaction Number',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Account Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: AccountNumber,
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
                          hintText: 'Enter Account Number',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Issued Bank Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: IssuedBankName,
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
                          hintText: 'Enter Issued Bank Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Issued Branch Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: IssuedBanchName,
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
                          hintText: 'Enter Issued Branch Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Issue Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 18,
                                      )),
                                  SizedBox(
                                      width:
                                          10), // Adjust the space between icon and text
                                  Text(
                                    checkInDate != ''
                                        ? "${selectedDate.toLocal()}"
                                            .split(' ')[0]
                                        : "${checkInDate}",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Remarks:',
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
                        controller: Remarks,
                        decoration: InputDecoration(
                          hintText: '  Remarks',
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
                          print(__futureLogin = ResponseHandler.performPost(
                              "CreditBalanceRequestSet",
                              "ManageDepositId=0&UserId=${userID.toString()}&UserTypeId=${userTypeID.toString()}&PaymentModeId=1&PaymentType=${PaymentType.toString()}&CurrencyID=1&DepositAmount=${DepositAmountController.text.toString()}"
                                  "&AuthorizedBy=${selectedOption.toString()}&TransactionNo=${_TransactionNumber.toString()}.text&AccountNo=${AccountNumber.text.toString()}&IssuedBankName=${IssuedBankName.text.toString()}&IssuedBranchName=${IssuedBanchName.text.toString()}&IssueDate=${formattedDate.toString()}&Remarks=${Remarks.text.toString()}"));

                          print("ManageDepositId=0"
                              "&UserId=$userID"
                              "&UserTypeId=$userTypeID"
                              "&PaymentModeId=1"
                              "&PaymentType=$PaymentType"
                              "&CurrencyID=1"
                              "&DepositAmount=${DepositAmountController.text}"
                              "&AuthorizedBy=$selectedOption"
                              "&TransactionNo=${_TransactionNumber.text}"
                              "&AccountNo=${AccountNumber.text}"
                              "&IssuedBankName=${IssuedBankName.text}"
                              "&IssuedBranchName=${IssuedBanchName.text}"
                              "&IssueDate=$formattedDate"
                              "&Remarks=${Remarks.text}");
                          __futureLogin?.then((value) {
                            print('Response body: ${value.body}');

                            String jsonResponse =
                                ResponseHandler.parseData(value.body);

                            print('JSON Response: ${jsonResponse}');
                            Navigator.pop(context);
                          });
                        },
                        child: SizedBox(
                            width: 115,
                            height: 40,
                            child: Center(
                              child: Text(
                                'Request',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            )),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Adjust the radius as needed
                          ), // Text color
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red, shape: RoundedRectangleBorder(
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
    );
  }
}
