class Flight_VouchersListModel {
  String bookFlightId;
  String bookingId;
  String bookingItemId;
  String bookingNumber;
  String bookingType;
  String bookingStatus;
  String ticketCode;
  String ticketNo;
  String bookingCreator;
  String dueDate;
  String agencyBranchName;
  String bookedOnDt;
  String authorizedBy;
  String salesChannel;
  String bookingTotalAmount;
  String bookingNumber1;
  String currentDt;
  String documentStatus;
  String requestStatus;
  String payStatus;

  Flight_VouchersListModel({
    required this.bookFlightId,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookingNumber,
    required this.bookingType,
    required this.bookingStatus,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingCreator,
    required this.dueDate,
    required this.agencyBranchName,
    required this.bookedOnDt,
    required this.authorizedBy,
    required this.salesChannel,
    required this.bookingTotalAmount,
    required this.bookingNumber1,
    required this.currentDt,
    required this.documentStatus,
    required this.requestStatus,
    required this.payStatus,
  });

  factory Flight_VouchersListModel.fromJson(Map<String, dynamic> json) {
    return Flight_VouchersListModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingCreator: json['BookingCreator'].toString(),
      dueDate: json['DueDate'].toString(),
      agencyBranchName: json['AgencyBranchName'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      salesChannel: json['SalesChannel'].toString(),
      bookingTotalAmount: json['BookingTotalAmount'].toString(),
      bookingNumber1: json['BookingNumber1'].toString(),
      currentDt: json['CurrentDt'].toString(),
      documentStatus: json['DocumentStatus'].toString(),
      requestStatus: json['RequestStatus'].toString(),
      payStatus: json['PayStatus'].toString(),
    );
  }
}
