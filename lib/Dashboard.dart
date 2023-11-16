import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'BookNow/BusScreen.dart';
import 'BookNow/CarScreen.dart';
import 'BookNow/FlightScreen.dart';
import 'BookNow/HolidaysScreen.dart';
import 'BookNow/hotelScreen.dart';
import 'Charges Payment/CancellationCharges.dart';
import 'Help/CreateTicket.dart';
import 'Help/OpenTicket.dart';
import 'Help/ResolvedTickets.dart';
import 'IssueVouchers.dart';
import 'MyBookings(BookingCard).dart';
import 'Recharge/BroadbandPayment.dart';
import 'Recharge/CheckTransactionReport.dart';
import 'Recharge/DTHRecharge.dart';
import 'Recharge/DataCardRecharge.dart';
import 'Recharge/ElectricityPayment.dart';
import 'Recharge/GasBillPaymets.dart';
import 'Recharge/LandlineRecharge.dart';
import 'Recharge/LifeInsurancePayment.dart';
import 'Recharge/MobilePostPaidRecharge.dart';
import 'Recharge/MobilePrepaidRecharge.dart';
import 'Recharge/RechargeHistoryReport.dart';
import 'Recharge/pendingRecharge.dart';
import 'Reports/ChangingRequestReport.dart';
import 'Reports/ClientInvoiceReport.dart';
import 'Reports/FinancialReport.dart';
import 'Reports/InvoiceReport.dart';
import 'Reports/LedgerSttementReport.dart';
import 'Reports/PaymentCollectionReport.dart';
import 'Reports/RequestCancellationReport.dart';
import 'Reports/TicketReport.dart';
import 'Reports/UnTicketReport.dart';
import 'Reports/WalletStatementReport.dart';
import 'SMS/EmailTicket.dart';
import 'home/bookings_chart.dart';
import 'home/events_chart.dart';
import 'home/passengers_chart.dart';
import 'Invoices/ClientInvoceList.dart';
import 'Invoices/CreditNoteInvoiceList.dart';
import 'Invoices/InvoiceList.dart';
import 'Reports/BookingCancellationReport.dart';
import 'Reports/BookingReport.dart';
import 'Reports/UnConfirmedBooking.dart';

class Dashboard extends StatefulWidget {
  @override
  _CorDashboardState createState() => _CorDashboardState();
}

class _CorDashboardState extends State<Dashboard> {
  Future<http.Response>? __futureLogin;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isInvoiceSelected = false;
  late String Balance = "",
      Balance1 = '',
      affiliate = "",
      TotalEarnings = "",
      AvailableBalance = "",
      DirectIncome = "",
      LevelIncome = "",
      BinaryIncome = "",
      Notification = "",
      Kyc = "",
      UnusedEpins = "",
      UsedEpins = "",
      TransferedEpins = "",
      ReceivedEpins = "",
      TotalWithdrawals = "",
      FundTrasnfered = "",
      FundReceived = "",
      MessageSent = "",
      Inbox = "",
      TotalOrders = "",
      NewOrders = "",
      CompletedOrders = "",
      PersonalMember = "",
      TeamMember = "";
  String? UserId;
  String? Name;
  String imageUrl = '';
  String? UserName;
  bool ispremium = false;
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF152238),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 27,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '9300140867',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 80),
            Image.asset(
              'assets/images/logo.png',
              alignment: Alignment.center,
              width: 100,
              height: 50,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Corp Admin",
                    style: TextStyle(fontFamily: "Montserrat")),
                accountEmail: Text("corpadmin@email.com",
                    style: TextStyle(fontFamily: "Montserrat")),
                decoration: BoxDecoration(color: Colors.blue),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Text("CA", style: TextStyle(fontFamily: "Montserrat"))),
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
                title: Text("Dashboard",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              ExpansionTile(
                title: Text("Book Now",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xee5e, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FlightsScreen()));
                    },
                    title: Text("Flights",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HotelsScreen()));
                    },
                    title: Text("Hotels",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => CabsScreen()));
                    },
                    title: Text("Cars",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Holidays()));
                    },
                    title: Text("Holidays",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => BusScreen()));
                    },
                    title: Text("Buses",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyBookings()));
                },
                leading: Icon(Icons.home),
                title: Text("My Bookings",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => IssueVouchers()));
                },
                leading: Icon(Icons.home),
                title: Text("Issue Vouchers",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              // ListTile(onTap: (){}, leading: Icon(Icons.book_online_outlined), title:  Text("Bookings", style: TextStyle(fontFamily: "Montserrat")),),

              ExpansionTile(
                title: Text("Invoices",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xee5e, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InvoiceList()));
                    },
                    title: Text("Invoice List",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ClientInvoiceList()));
                    },
                    title: Text("Client Invoice List",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditNoteInvoiceList()));
                    },
                    title: Text("Credit Note",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EmailTicket()));
                },
                leading: Icon(Icons.home),
                title: Text("SMS/Email Ticket",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),

              ExpansionTile(
                title: Text("Charges/Payment",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe4fb, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CancellationCharges()));
                    },
                    title: Text("Cancellation Charges",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CancelledBookingB2B()));*/
                    },
                    title: Text("Make Payment",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),

              ExpansionTile(
                title: Text("Recharges",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe140, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MobilePrepaidRecharge()));
                    },
                    title: Text("Mobile Prepaid",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MobilePostpaidRecharge()));
                    },
                    title: Text("Mobile Postpaid",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LandlineRecharge()));
                    },
                    title: Text("Landline Phone",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BroadbandPayment()));
                    },
                    title: Text("BroadBand",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DataCardRecharge()));
                    },
                    title: Text("Data Card",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DTHRecharge()));
                    },
                    title:
                        Text("DTH", style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ElectricityPayment()));
                    },
                    title: Text("Electricity",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GasBillPaymets()));
                    },
                    title:
                        Text("Gas", style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LifeInsurancePayment()));
                    },
                    title: Text("Life Insurance",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  pendingRecharge()));
                    },
                    title: Text("Pending Recharge",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RechargeHistoryReport()));
                    },
                    title: Text("Recharge History",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CheckTransactionReport()));
                    },
                    title: Text("Check Transaction",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),

              ExpansionTile(
                title: Text("Reporting",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe621, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingReport()));
                    },
                    title: Text("Booking Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingCancellationReport()));
                    },
                    title: Text("Booking Cancellation Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UnConfirmedBooking()));
                    },
                    title: Text("UnConfirmed Booking",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RequestCancellationReport()));
                    },
                    title: Text("Request Cancellation Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChangingRequestReport()));
                    },
                    title: Text("Changing Request Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ClientInvoiceReport()));
                    },
                    title: Text("Client Invoice Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InvoiceReport()));
                    },
                    title: Text("Invoice Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LedgerSttementReport()));
                    },
                    title: Text("Ledger Statement Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaymentCollectionReport()));
                    },
                    title: Text("Payment Collection Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TicketReport()));
                    },
                    title: Text("Ticket Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UnTicketReport()));
                    },
                    title: Text("Unticket Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FinancialReport()));
                    },
                    title: Text("Financial Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  WalletStatementReport()));
                    },
                    title: Text("Wallet Statement Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),

              ExpansionTile(
                title:
                    Text("Wallets", style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe19a, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text("Credit Usage",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Credit Balance Request",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Credit Request Approved",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Credit Request Rejected",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Credit Request Receipt",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Fund Transfer",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Fund Transfer History",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Fund Received History",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),

              ExpansionTile(
                title: Text("Help/Support",
                    style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe2eb, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateTicket()));
                    },
                    title: Text("Create Ticket",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => OpenTicket()));
                    },
                    title: Text("Open Ticket",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResolvedTickets()));
                    },
                    title: Text("Resolved Tickets",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Closed Tickets",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Archived Tickets",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xff41d1d1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Bookings',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '421',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xff3050af),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Approval Requests',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '39',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xffeb8899),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Approved Policy',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '28',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xffe7a236),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rejected Policy',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '39',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            'Bookings',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: BookingsChart(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            'Passengers',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: PassengersChart(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            'Events',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: EventsChart(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.blue, // Background color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Book Now",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "My Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Vouchers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Wallets"),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
      ),
    );
  }
}
