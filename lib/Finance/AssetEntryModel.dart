class AssetEntryModel {
  String slNo;
  String assetEntryId;
  String assetName;
  String purchaseInvoice;
  String purchaseDate;
  String grossPurchaseAmount;
  String assetEntry;
  int status;
  String userTypeId;
  String userId;
  String createdDate;
  String currencyCode;

  AssetEntryModel({
    required this.slNo,
    required this.assetEntryId,
    required this.assetName,
    required this.purchaseInvoice,
    required this.purchaseDate,
    required this.grossPurchaseAmount,
    required this.assetEntry,
    required this.status,
    required this.userTypeId,
    required this.userId,
    required this.createdDate,
    required this.currencyCode,
  });

  factory AssetEntryModel.fromJson(Map<String, dynamic> json) {
    return AssetEntryModel(
      slNo: json['SlNo'].toString(),
      assetEntryId: json['AssetEntryId'].toString(),
      assetName: json['AssetName'].toString(),
      purchaseInvoice: json['PurchaseInvoice'].toString(),
      purchaseDate: json['PurchaseDate'].toString(),
      grossPurchaseAmount: json['GrossPurchaseAmount'].toString(),
      assetEntry: json['AssetEntry'].toString(),
      status: json['Status'],
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      createdDate: json['CreatedDate'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
    );
  }
}
