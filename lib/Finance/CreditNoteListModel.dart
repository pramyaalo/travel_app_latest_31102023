class CreditNoteListModel {
  String slNo;
  String userTypeId;
  String userId;
  String bookFlightId;
  String invoiceNo;
  String ticketNo;
  String bookedOnDt;
  String bookingType;
  String bookingId;
  String itinerary;
  String paxName;
  String totalAmt;
  String bookingStatus;
  String totalTax;
  String totalSales;
  String paxName1;
  String flightDetails;
  String baggage;
  String bookingNumber;
  String currency;

  CreditNoteListModel({
    required this.slNo,
    required this.userTypeId,
    required this.userId,
    required this.bookFlightId,
    required this.invoiceNo,
    required this.ticketNo,
    required this.bookedOnDt,
    required this.bookingType,
    required this.bookingId,
    required this.itinerary,
    required this.paxName,
    required this.totalAmt,
    required this.bookingStatus,
    required this.totalTax,
    required this.totalSales,
    required this.paxName1,
    required this.flightDetails,
    required this.baggage,
    required this.bookingNumber,
    required this.currency,
  });

  factory CreditNoteListModel.fromJson(Map<String, dynamic> json) {
    return CreditNoteListModel(
      slNo: json['SlNo'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      invoiceNo: json['Invoiceno'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingId: json['BookingId'].toString(),
      itinerary: json['Itinerary'].toString(),
      paxName: json['PaxName'].toString(),
      totalAmt: json['TotalAmt'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      totalTax: json['TotalTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      paxName1: json['PaxName1'].toString(),
      flightDetails: json['FlightDetails'].toString(),
      baggage: json['Baggage'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      currency: json['Currency'].toString(),
    );
  }
}
