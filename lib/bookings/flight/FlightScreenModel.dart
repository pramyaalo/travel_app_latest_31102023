class FlightScreenModel {
  final String id;
  final String name;
  final String municipality;

  FlightScreenModel(
      {required this.id, required this.name, required this.municipality});

  factory FlightScreenModel.fromJson(Map<String, dynamic> json) {
    return FlightScreenModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      municipality: json['municipality'] ?? '',
    );
  }
}
