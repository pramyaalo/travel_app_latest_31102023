class Table2FlightModel {
  String bftfPlightId;
  String type;
  String passenger;
  String tfpDob;
  String tfpIdentityNo;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String ticketNo;
  String custPhone;
  String custEmail;
  String age;
  String addressLine1;
  String addressLine2;
  String city;
  String countryName;
  String passengerId;

  Table2FlightModel({
    required this.bftfPlightId,
    required this.type,
    required this.passenger,
    required this.tfpDob,
    required this.tfpIdentityNo,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.ticketNo,
    required this.custPhone,
    required this.custEmail,
    required this.age,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.countryName,
    required this.passengerId,
  });

  factory Table2FlightModel.fromJson(Map<String, dynamic> json) {
    return Table2FlightModel(
      bftfPlightId: json['BFTFPlightID'].toString(),
      type: json['Type'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDob: json['TFPDOB'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      pnr: json['PNR'].toString(),
      ticketNo: json['TicketNo'].toString(),
      custPhone: json['CustPhone'].toString(),
      custEmail: json['CustEmail'].toString(),
      age: json['Age'].toString(),
      addressLine1: json['AddressLine1'].toString(),
      addressLine2: json['AddressLine2'].toString(),
      city: json['City'].toString(),
      countryName: json['CountryName'].toString(),
      passengerId: json['PassengerID'].toString(),
    );
  }
}
