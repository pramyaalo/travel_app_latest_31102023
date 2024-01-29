class FareBreakdownModel {
  String fareBreakdownID;
  String fbBookFlightId;
  String balanceDueDate;
  String inputTax;
  String outputTax;
  String totalSales;
  String totalNett;
  String totalProfit;
  String currency;
  String balanceDueDt;

  FareBreakdownModel({
    required this.fareBreakdownID,
    required this.fbBookFlightId,
    required this.balanceDueDate,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
    required this.totalProfit,
    required this.currency,
    required this.balanceDueDt,
  });

  factory FareBreakdownModel.fromJson(Map<String, dynamic> json) {
    return FareBreakdownModel(
      fareBreakdownID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
      totalProfit: json['TotalProfit'].toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
    );
  }
}

void main() {
  // Example of usage:
  List<Map<String, dynamic>> jsonData = [
    {
      "FareBreakdowID": 2575,
      "FBBookFlightId": 2648,
      "BalanceDueDate": "2023-11-06T17:41:46",
      "InputTax": 6831.01,
      "OutputTax": 1100.00,
      // ... (other fields)
    },
  ];

  List<FareBreakdownModel> fareBreakdowns =
      jsonData.map((data) => FareBreakdownModel.fromJson(data)).toList();

  // Accessing individual properties:
  print("First fare breakdown currency: ${fareBreakdowns[0].currency}");
}
