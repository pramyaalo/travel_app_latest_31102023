class Table11InvoiceHotelreceiptModel {
  String corporateId;
  String corporateName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String postCode;
  String phone;
  String email;

  Table11InvoiceHotelreceiptModel({
    required this.corporateId,
    required this.corporateName,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.postCode,
    required this.phone,
    required this.email,
  });

  factory Table11InvoiceHotelreceiptModel.fromJson(Map<String, dynamic> json) {
    return Table11InvoiceHotelreceiptModel(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['Corporate Name'].toString(),
      addressLine1: json['AddressLine1'].toString(),
      addressLine2: json['AddressLine2'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      city: json['City'].toString(),
      postCode: json['PostCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['EMail'].toString(),
    );
  }
}
