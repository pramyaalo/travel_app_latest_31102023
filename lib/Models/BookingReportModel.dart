class BookingReportModel {
  String slNo;
  String bookingId;
  String bookingNumber;
  String bookingStatus;
  String bookFlightId;
  String bookedOnDt;
  String ticketCode;
  String ticketNo;
  String tripDate;
  String originDestination;
  String passenger;
  String bookedProduct;
  String journeyType;
  String totalAmount;
  String tripType;
  String bookCardAmount;
  String paidStatus;
  String payMode;

  BookingReportModel({
    required this.slNo,
    required this.bookingId,
    required this.bookingNumber,
    required this.bookingStatus,
    required this.bookFlightId,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.tripDate,
    required this.originDestination,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmount,
    required this.tripType,
    required this.bookCardAmount,
    required this.paidStatus,
    required this.payMode,
  });

  factory BookingReportModel.fromJson(Map<String, dynamic> json) {
    return BookingReportModel(
      slNo: json['SlNo'],
      bookingId: json['BookingId'],
      bookingNumber: json['BookingNumber'],
      bookingStatus: json['BookingStatus'],
      bookFlightId: json['BookFlightId'],
      bookedOnDt: json['BookedOnDt'],
      ticketCode: json['TicketCode'],
      ticketNo: json['TicketNo'],
      tripDate: json['TripDate'],
      originDestination: json['OriginDestination'],
      passenger: json['Passenger'],
      bookedProduct: json['BookedProduct'],
      journeyType: json['JourneyType'],
      totalAmount: json['TotalAmt'].toDouble(),
      tripType: json['TripType'],
      bookCardAmount: json['BookCardAmount'].toDouble(),
      paidStatus: json['PaidStatus'],
      payMode: json['PayMode'],
    );
  }
}
