class Table7ClientInvoiceHotelReceiptModel {
  String thhBookFlightId;
  String hotelName;
  String starCategory;
  String hotelAddress;
  String noOfNights;
  String rateCode;
  String cityCode;
  String phone;
  String email;
  String supplierRefNo;
  String confirmationNo;
  String additionalRefNo;
  String checkInDt;
  String checkOutDt;
  String checkInDtt;
  String checkOutDtt;
  String confirmationNo1;
  String roomType;

  Table7ClientInvoiceHotelReceiptModel({
    required this.thhBookFlightId,
    required this.hotelName,
    required this.starCategory,
    required this.hotelAddress,
    required this.noOfNights,
    required this.rateCode,
    required this.cityCode,
    required this.phone,
    required this.email,
    required this.supplierRefNo,
    required this.confirmationNo,
    required this.additionalRefNo,
    required this.checkInDt,
    required this.checkOutDt,
    required this.checkInDtt,
    required this.checkOutDtt,
    required this.confirmationNo1,
    required this.roomType,
  });

  factory Table7ClientInvoiceHotelReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table7ClientInvoiceHotelReceiptModel(
      thhBookFlightId: json['THHBookFlightId'].toString(),
      hotelName: json['HotelName'].toString(),
      starCategory: json['StarCategory'].toString(),
      hotelAddress: json['HotelAddress'].toString(),
      noOfNights: json['NoofNights'].toString(),
      rateCode: json['RateCode'].toString(),
      cityCode: json['CityCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
      supplierRefNo: json['SupplierRefNo'].toString(),
      confirmationNo: json['ConfirmationNo'].toString(),
      additionalRefNo: json['AdditionalReffNo'].toString(),
      checkInDt: json['CheckInDt'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      checkInDtt: json['CheckInDtt'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
      confirmationNo1: json['ConfirmationNo1'].toString(),
      roomType: json['RoomType'].toString(),
    );
  }
}
