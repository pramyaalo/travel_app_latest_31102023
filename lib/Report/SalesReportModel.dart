class SalesReportModel {
  int slNo;
  int bookFlightId;
  String bookingID;
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

  SalesReportModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingID,
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

  factory SalesReportModel.fromJson(Map<String, dynamic> json) {
    return SalesReportModel(
      slNo: json['SlNo'],
      bookFlightId: json['BookFlightId'],
      bookingID: json['BookingID'],
      bookedOnDt: json['BookedOnDt'],
      ticketCode: json['TicketCode'],
      ticketNo: json['TicketNo'],
      originDestination: json['OriginDestination'],
      passenger: json['Passenger'],
      bookedProduct: json['BookedProduct'],
      journeyType: json['JourneyType'],
      totalAmt: json['TotalAmt'],
      tripType: json['TripType'],
      bookingAmount: json['BookingAmount'],
    );
  }
}
