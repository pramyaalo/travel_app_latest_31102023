class BusBookingModel {
  String busHeadID;
  String travelName;
  String busType;
  String originCityLocation;
  String destinationCityLocation;
  String originCityTime;
  String destinationCityTime;
  String originCityDate;
  String destinationCityDate;
  String availableSeats;

  BusBookingModel({
    required this.busHeadID,
    required this.travelName,
    required this.busType,
    required this.originCityLocation,
    required this.destinationCityLocation,
    required this.originCityTime,
    required this.destinationCityTime,
    required this.originCityDate,
    required this.destinationCityDate,
    required this.availableSeats,
  });

  factory BusBookingModel.fromJson(Map<String, dynamic> json) {
    return BusBookingModel(
      busHeadID: json['BusHeadID'].toString(),
      travelName: json['TravelName'].toString(),
      busType: json['Bustype'].toString(),
      originCityLocation: json['OriginCityLocation'].toString(),
      destinationCityLocation: json['DestinationCityLocation'].toString(),
      originCityTime: json['OriginCityTime'].toString(),
      destinationCityTime: json['DestinationCityTime'].toString(),
      originCityDate: json['OriginCityDate'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
      availableSeats: json['AvailableSeats'].toString(),
    );
  }
}
