class InvoiceReceiptModel {
  String slNo;
  String bookFlightId;
  String bookingId;
  String bookedOnDt;
  String ticketCode;
  String ticketNo;
  String originDestination;
  String passenger;
  String bookedProduct;
  String journeyType;
  String totalAmt;
  String tripType;
  String bookingAmount;

  InvoiceReceiptModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingId,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.originDestination,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmt,
    required this.tripType,
    required this.bookingAmount,
  });

  factory InvoiceReceiptModel.fromJson(Map<String, dynamic> json) {
    return InvoiceReceiptModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingID'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      originDestination: json['OriginDestination'].toString(),
      passenger: json['Passenger'].toString(),
      bookedProduct: json['BookedProduct'].toString(),
      journeyType: json['JourneyType'].toString(),
      totalAmt: json['TotalAmt'].toString(),
      tripType: json['TripType'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
    );
  }
}
