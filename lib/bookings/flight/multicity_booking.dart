import 'package:flutter/material.dart';

import '../../utils/commonutils.dart';

class MultiCityBooking extends StatefulWidget {
  final flightDetail;
  const MultiCityBooking({super.key, required this.flightDetail});

  @override
  State<MultiCityBooking> createState() => _MultiCityBookingState();
}

class _MultiCityBookingState extends State<MultiCityBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flight Booking",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                'assets/images/img.png',
                                                height: 50,
                                                width: 50,
                                              )),
                                          Text(
                                            widget.flightDetail[
                                                    'CarrierNameFirst']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff777777)),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${CommonUtils.convertToFormattedTime(widget.flightDetail['DepartureDateFirst'].toString())} - ${CommonUtils.convertToFormattedTime(widget.flightDetail['ArrivalDateFirst'].toString())}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  widget.flightDetail[
                                                          'DepartCityCodeFirst']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                              Icon(Icons.arrow_right_alt),
                                              Row(
                                                children: [
                                                  Text(
                                                      widget.flightDetail[
                                                              'ArriveCityCodeFirst']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff777777),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13)),
                                                  Text(
                                                    ' ${widget.flightDetail['StopCountFirst'].toString()} stops',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                'assets/images/img.png',
                                                height: 50,
                                                width: 50,
                                              )),
                                          Text(
                                            widget.flightDetail[
                                                    'CarrierNameSecond']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff777777)),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${CommonUtils.convertToFormattedTime(widget.flightDetail['DepartureDateSecond'].toString())} - ${CommonUtils.convertToFormattedTime(widget.flightDetail['ArrivalDateSecond'].toString())}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  widget.flightDetail[
                                                          'DepartCityCodeSecond']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff777777),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                              Icon(Icons.arrow_right_alt),
                                              Row(
                                                children: [
                                                  Text(
                                                      widget.flightDetail[
                                                              'ArriveCityCodeSecond']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff777777),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13)),
                                                  Text(
                                                    ' ${widget.flightDetail['StopCountSecond'].toString()} stops',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.flightDetail['Currency'].toString()} ${widget.flightDetail['TotalPrice'].toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.flightDetail['Refundable'].toString(),
                            style: TextStyle(
                                color: Color(0xff11A578), fontSize: 13),
                          ),
                          Text(
                            'Fare Details',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 13),
                          ),
                          Text(
                            'More Details',
                            style: TextStyle(
                                color: Color(0xffdf7417), fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Traveller Details',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'First Name',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Last Name',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Date of birth',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Nationality',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Document Number',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Expiry Date',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Contact Details',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Email Address',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Mobile Number',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Address',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'City',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Country',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 10.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  shadowColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(10.0),
                  minimumSize: const Size(double.infinity, 50.0),
                ),
                child: const Text(
                  "Continue Booking",
                  style: TextStyle(fontFamily: "Montserrat"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
