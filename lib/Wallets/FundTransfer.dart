import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FundTransfer(),
    );
  }
}

class FundTransfer extends StatefulWidget {
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<FundTransfer> {
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
              "Fund Transfer",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 17),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
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
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      'Please Transfer the Fund here..',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Ewallet Balance (BRL):',
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
                          hintText: 'Enter Balance',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                        'Transfer To',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                        hintText: 'Enter Customer Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Transaction Amount (BRL):',
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
                          hintText: 'Enter Transaction Amount',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Transaction Password:',
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
                          hintText: 'Enter Transaction Password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320, height: 45, // Set width to full
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your recharge logic here
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellow, // Set button color
                            ),
                            child: Text(
                              'Fund Transfer',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        // Other widgets below the button
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NOTE:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 10),
                          Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            'You can Transfer the Fund in this EWallet. It will calculate on Transfer Fund Reports by default!.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
