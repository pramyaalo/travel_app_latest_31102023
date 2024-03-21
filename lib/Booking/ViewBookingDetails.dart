import 'package:flutter/material.dart';

import 'BookedItemDetail.dart';
import 'CancellationRequestDetails.dart';
import 'ChangingDetails.dart';
import 'ContactDetaails.dart';
import 'PaymentTransactions.dart';

class ViewBookingDetails extends StatefulWidget {
  final id;
  const ViewBookingDetails({super.key, required this.id});
  @override
  State<ViewBookingDetails> createState() =>
      _BookingCardsDetailsContainerState();
}

class _BookingCardsDetailsContainerState extends State<ViewBookingDetails>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void initState() {
    //_tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  int index = 0;

  late List<Widget> tabs = [
    BookedItemDetail(
      id: widget.id,
    ),
    ContactDetaails( id: widget.id,),
    PaymentTransactions( id: widget.id,),
    ChangingDetails( id: widget.id,),
    CancellationRequestDetails( id: widget.id,)
  ];

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
              "Booking Details",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xff74206b)),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == 0 ? Color(0xff74206b) : Colors.white),
                        height: 40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          "General",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == 0 ? Colors.white : Colors.black),
                        )),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xff74206b)),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == 1 ? Color(0xff74206b) : Colors.white),
                        height: 40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          "Contact",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == 1 ? Colors.white : Colors.black),
                        )),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xff74206b)),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == 2 ? Color(0xff74206b) : Colors.white),
                        height: 40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          "Payment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == 2 ? Colors.white : Colors.black),
                        )),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 3;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xff74206b)),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == 3 ? Color(0xff74206b) : Colors.white),
                        height: 40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          "Changing",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == 3 ? Colors.white : Colors.black),
                        )),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 4;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xff74206b)),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == 4 ? Color(0xff74206b) : Colors.white),
                        height: 40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          "Cancellation",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == 4 ? Colors.white : Colors.black),
                        )),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: tabs[index]),
        ],
      ),
    );
  }
}
