import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:ravel_app_latest_31102023/utils/response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Charges Payment/CancellationCharges.dart';
import 'Finance/AssetEntry.dart';
import 'Finance/BalanceSheet.dart';
import 'Finance/ClientInvoices.dart';
import 'Finance/CreditNotes.dart';
import 'Finance/DebtorAgingReport.dart';
import 'Finance/FinancialBook.dart';
import 'Finance/InvoiceList.dart';
import 'Finance/JournalEntry.dart';
import 'Finance/ProfitandLoss.dart';
import 'Finance/TransactionReport.dart';
import 'Finance/TrialBalance.dart';
import 'Finance/Vouchers.dart';
import 'Help/CreateTicket.dart';
import 'Help/OpenTicket.dart';
import 'Help/ResolvedTickets.dart';
import 'Models/DashboardModel.dart';

import 'Queues/ApprovePartPayment.dart';
import 'Queues/ApproveRefundQueue.dart';
import 'Queues/CancelBookingQueue.dart';
import 'Queues/CancelTicketQueue.dart';
import 'Queues/FraudCheckQueue.dart';
import 'Queues/PendingQueue.dart';
import 'Queues/RefundedBookingQueue.dart';
import 'Queues/TicketOrderQueue.dart';
import 'Report/BookingCancellationReport.dart';
import 'Report/BookingReport.dart';
import 'Report/ChangingRequestReport.dart';
import 'Report/ClientInvoiceReport.dart';
import 'Report/InvoiceReport.dart';
import 'Report/LedgerStatementReport.dart';
import 'Report/PaymentCollectionReport.dart';
import 'Report/RequestCancellationReport.dart';
import 'Report/TicketReport.dart';
import 'Report/UnConfirmedBooking.dart';
import 'Report/UnTicketReport.dart';

import 'SMS/EmailTicket.dart';
import 'Travellers/ActiveTravellers.dart';
import 'Travellers/ApproveTravellers.dart';
import 'Travellers/ChangePasswordTravellers.dart';
import 'Travellers/ManageTravellers.dart';
import 'Travellers/UnBlockTravellers.dart';
import 'Wallets/CreditBalanceRequest.dart';
import 'Wallets/CreditRequestApproved.dart';
import 'Wallets/CreditRequestReceipt.dart';
import 'Wallets/CreditRequestRejected.dart';
import 'Wallets/CreditUsage.dart';
import 'Wallets/FundReceivedHistory.dart';
import 'Wallets/FundTransfer.dart';
import 'Wallets/FundTransferHistory.dart';
import 'bookings/flight/flight_screen.dart';
import 'bookings/holidays/HolidaysScreen.dart';
import 'bookings/hotels/hotels_screen.dart';
import 'home/bookings_chart.dart';
import 'home/events_chart.dart';
import 'home/passengers_chart.dart';

class Dashboard extends StatefulWidget {
  @override
  _CorDashboardState createState() => _CorDashboardState();
}

class _CorDashboardState extends State<Dashboard> {
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;
  Future<String?> getInvoiceReceiptJSON() async {
    Future<http.Response>? futureLabels =
        ResponseHandler.performPost("B2CDashboard", "UserTypeId=8&UserId=2312");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];
      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }

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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
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
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '9300140867',
                  style: TextStyle(
                    color: Colors.black,
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
                decoration: BoxDecoration(color: Color(0xff74206b)),
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
                title:
                    Text("Booking", style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xee5e, fontFamily: 'MaterialIcons')),
                children: [
                  ExpansionTile(
                    title: Text("Book Now",
                        style: TextStyle(fontFamily: "Montserrat")),
                    leading: Icon(
                        const IconData(0xee5e, fontFamily: 'MaterialIcons')),
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FlightScreen()));
                        },
                        leading: Icon(Icons.threesixty_outlined),
                        title: Text("Flight",
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
                        leading: Icon(Icons.search),
                        title: Text("Hotel",
                            style: TextStyle(fontFamily: "Montserrat")),
                      ),
                      ListTile(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CancelTicketQueue()));*/
                        },
                        leading: Icon(Icons.swipe_up_alt),
                        title: Text("Car",
                            style: TextStyle(fontFamily: "Montserrat")),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Holidays()));
                        },
                        leading: Icon(Icons.lock_open_outlined),
                        title: Text("Holiday",
                            style: TextStyle(fontFamily: "Montserrat")),
                      ),
                      ListTile(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ApproveRefundQueue()));*/
                        },
                        leading: Icon(Icons.lock_open_outlined),
                        title: Text("Bus",
                            style: TextStyle(fontFamily: "Montserrat")),
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: () {
                      /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingCard()));*/
                    },
                    leading: Icon(Icons.ramp_right),
                    title: Text("Booking Card",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NewBookings()));*/
                    },
                    leading: Icon(Icons.contacts),
                    title: Text("New Booking",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OpenBooking()));*/
                    },
                    leading: Icon(Icons.payments_outlined),
                    title: Text("Open Booking",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PartPayment()));*/
                    },
                    leading: Icon(Icons.terminal_rounded),
                    title: Text("Part Payment",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PendingPayment()));*/
                    },
                    leading: Icon(Icons.swipe_up),
                    title: Text("Pending Payment",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ServiceRequest()));*/
                    },
                    leading: Icon(Icons.align_horizontal_left),
                    title: Text("Service Request",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UnconfirmedBooking()));*/
                    },
                    leading: Icon(Icons.shopping_cart_rounded),
                    title: Text("UnConfirmed Booking",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CancelledBooking()));*/
                    },
                    leading: Icon(Icons.payment),
                    title: Text("Cancelled Flight Booking",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingRefundsDue()));*/
                    },
                    leading: Icon(Icons.account_tree_sharp),
                    title: Text("Booking Refunds Due",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AllBooking()));*/
                    },
                    leading: Icon(Icons.rotate_left_rounded),
                    title: Text("All Bookings List",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AllProductWiseBooking()));*/
                    },
                    leading: Icon(Icons.payments_sharp),
                    title: Text("Productwise Bookings",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ExpansionTile(
                title:
                    Text("Queues", style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xee5e, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TicketOrderQueue()));
                    },
                    leading: Icon(Icons.threesixty_outlined),
                    title: Text("Ticket Order Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CancelBookingQueue()));
                    },
                    leading: Icon(Icons.search),
                    title: Text("Cancel Booking Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CancelTicketQueue()));
                    },
                    leading: Icon(Icons.swipe_up_alt),
                    title: Text("Cancel Ticket Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ApprovePartPayment()));
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Approve Part Payment",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ApproveRefundQueue()));
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Approve Refund OnHold",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PendingQueue()));
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Payment Pending Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FraudCheckQueue()));
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Fraud Check Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RefundedBookingQueue()));
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Refunded Booking Queue",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text("Travellers",
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
                                  ManageTravellers()));
                    },
                    leading: Icon(Icons.perm_identity_outlined),
                    title: Text("Travellers",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ApproveTravellers()));
                    },
                    leading: Icon(Icons.handshake_outlined),
                    title: Text("Approve Travellers",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UnBlockTravellers()));
                    },
                    leading: Icon(Icons.threesixty_outlined),
                    title: Text("Block/UnBlock Travellers",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ActiveTravellers()));
                    },
                    leading: Icon(Icons.computer),
                    title: Text("Active Travellers",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChangePasswordTravellers()));
                    },
                    leading: Icon(Icons.password_rounded),
                    title: Text("Change Password",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Vouchers()));
                },
                leading: Icon(Icons.align_vertical_bottom_outlined),
                title: Text("Issue Vouchers",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
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
                    leading: Icon(Icons.computer_outlined),
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
                    leading: Icon(Icons.pause_presentation_outlined),
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
                    leading: Icon(Icons.surround_sound),
                    title: Text("Credit Note",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ExpansionTile(
                title:
                    Text("Finance", style: TextStyle(fontFamily: "Montserrat")),
                leading:
                    Icon(const IconData(0xe2eb, fontFamily: 'MaterialIcons')),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AssetEntry(
                                    Id: '',
                                  )));
                    },
                    title: Text("Asset Entry",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => JournalEntry(
                                    Id: "",
                                  )));
                    }, //JournalEntry
                    title: Text("Journal Entry",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CheckTransactionReport()));
                    }, //CheckTransactionReport
                    title: Text("Transactions Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FinancialBook()));
                    }, //FinancialBook
                    title: Text("Financial Book",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DebtorAgingReport()));
                    }, //DebtorAgingReport
                    title: Text("Debtor Aging Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfitandLoss()));
                    }, //ProfitandLoss
                    title: Text("Profit and Loss",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BalanceSheet()));
                    }, //BalanceSheet
                    title: Text("Balance Sheet",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TrialBalance()));
                    }, //TrialBalance
                    title: Text("Trial Balance",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                ],
              ),
              ExpansionTile(
                title:
                    Text("Reports", style: TextStyle(fontFamily: "Montserrat")),
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
                    leading: Icon(Icons.computer),
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
                    leading: Icon(Icons.arrow_circle_left_outlined),
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
                    leading: Icon(Icons.adjust_rounded),
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
                    leading: Icon(Icons.volume_down_alt),
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
                    leading: Icon(Icons.minimize),
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
                    leading: Icon(Icons.attach_money_outlined),
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
                    leading: Icon(Icons.book_online_sharp),
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
                    leading: Icon(Icons.payments_sharp),
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
                    leading: Icon(Icons.payments_rounded),
                    title: Text("Payment Collection Report",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SalesReport()));*/
                    },
                    leading: Icon(Icons.handshake),
                    title: Text("Sales Report",
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
                    leading: Icon(Icons.handshake_outlined),
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
                    leading: Icon(Icons.album_rounded),
                    title: Text("Unticket Report",
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditUsage()));
                    },
                    title: Text("Credit Usage",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditBalanceRequest()));
                    },
                    title: Text("Credit Balance Request",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditRequestApproved()));
                    },
                    title: Text("Credit Request Approved",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditRequestRejected()));
                    },
                    title: Text("Credit Request Rejected",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BalanceReceipt()));
                    },
                    title: Text("Credit Request Receipt",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FundTransfer()));
                    },
                    title: Text("Fund Transfer",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FundTransferHistory()));
                    },
                    title: Text("Fund Transfer History",
                        style: TextStyle(fontFamily: "Montserrat")),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FundReceivedHistory()));
                    },
                    title: Text("Fund Received History",
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
            Stack(
              children: <Widget>[
                // The containers in the background
                new Column(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height * .14,
                      decoration: BoxDecoration(
                        color: Color(0xff74206b),
                        boxShadow: [
                          BoxShadow(color: Color(0xff74206b), spreadRadius: 3)
                        ],
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width,
                            80.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FlightScreen()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 32,
                          right: 5.0,
                          left: 40.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/flights.png', // Replace 'assets/bus_icon.png' with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Flights',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HotelsScreen()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 35,
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/hotel.png', // Replace with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Hotels',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Holidays()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 35,
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/holiday.jpg', // Replace 'assets/bus_icon.png' with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Tours',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: FutureBuilder<String?>(
                  future: getInvoiceReceiptJSON(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      try {
                        log('Datagfggg: :${snapshot.data}');
                        Table0 m0 = Table0.fromJson(table0[0]);
                        Table1 m1 = Table1.fromJson(table1[0]);
                        Table2 m2 = Table2.fromJson(table2[0]);

                        Table3 m3 = Table3.fromJson(table3[0]);
                        Table4 m4 = Table4.fromJson(table4[0]);
                        Table5 m5 = Table5.fromJson(table5[0]);
                        Table6 m6 = Table6.fromJson(table6[0]);
                        log('Datagrrwwfggg: :${m6}');
                        return SingleChildScrollView(
                            child: Container(
                                margin: EdgeInsets.all(0),
                                child: InkWell(
                                    child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff41d1d1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Available Credit',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        m0.availableCredit,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff3050af),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Total Bookings',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        m0.totalBookings,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffeb8899),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Total Sales',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        m0.totalSales,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffe7a236),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Total Travellers',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        m0.totalPeople,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 20, 0, 20),
                                                      child: Text(
                                                        'Bookings',
                                                        style: TextStyle(
                                                            fontSize: 18),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 20, 0, 20),
                                                      child: Text(
                                                        'Passengers',
                                                        style: TextStyle(
                                                            fontSize: 18),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 20, 0, 20),
                                                      child: Text(
                                                        'Events',
                                                        style: TextStyle(
                                                            fontSize: 18),
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
                                ))));
                      } catch (error) {
                        print('Unexpected error: $error');
                        return Text('An unexpected error occurred.');
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Color(0xff74206b), // Background color
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
