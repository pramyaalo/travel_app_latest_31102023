class RefundPaymentModel {
  String custPaymentID;
  String cpBookFlightId;
  String currency;
  String dateOfPayment;
  String allocatedAmount;
  String balanceAmount;
  String refundDate;
  String createdDate;
  String refundAmount;
  String refundServiceAmount;
  String refundType;
  String refundStatus;
  String totalRefund;
  String bookingAmount;
  String cancellStatus;

  RefundPaymentModel({
    required this.custPaymentID,
    required this.cpBookFlightId,
    required this.currency,
    required this.dateOfPayment,
    required this.allocatedAmount,
    required this.balanceAmount,
    required this.refundDate,
    required this.createdDate,
    required this.refundAmount,
    required this.refundServiceAmount,
    required this.refundType,
    required this.refundStatus,
    required this.totalRefund,
    required this.bookingAmount,
    required this.cancellStatus,
  });

  factory RefundPaymentModel.fromJson(Map<String, dynamic> json) {
    return RefundPaymentModel(
      custPaymentID: json['CustPaymentID'].toString(),
      cpBookFlightId: json['CPBookFlightId'].toString(),
      currency: json['Currency'].toString(),
      dateOfPayment: json['DateOfPayment'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      balanceAmount: json['BalanceAmount'].toString(),
      refundDate: json['RefundDate'].toString(),
      createdDate: json['CreatedDate'].toString(),
      refundAmount: json['RefundAmount'].toString(),
      refundServiceAmount: json['RefundServiceAmount'].toString(),
      refundType: json['RefundType'].toString(),
      refundStatus: json['RefundStatus'].toString(),
      totalRefund: json['TotalRefund'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      cancellStatus: json['CancellStatus'].toString(),
    );
  }
}
