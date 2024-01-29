class JournalEntryModels {
  String slNo;
  String company;
  String journalEntryId;
  String serialNo;
  String referenceNo;
  String name;
  int status;
  String journalDate;
  String accountTypeName;
  String financeYear;
  String credit;
  String debit;
  String amount;
  String currencyCode;
  String userType;
  String userName;

  JournalEntryModels({
    required this.slNo,
    required this.company,
    required this.journalEntryId,
    required this.serialNo,
    required this.referenceNo,
    required this.name,
    required this.status,
    required this.journalDate,
    required this.accountTypeName,
    required this.financeYear,
    required this.credit,
    required this.debit,
    required this.amount,
    required this.currencyCode,
    required this.userType,
    required this.userName,
  });

  factory JournalEntryModels.fromJson(Map<String, dynamic> json) {
    return JournalEntryModels(
      slNo: json['SlNo'].toString(),
      company: json['Company'].toString(),
      journalEntryId: json['JournalEntryId'].toString(),
      serialNo: json['SerialNo'].toString(),
      referenceNo: json['ReferenceNo'].toString(),
      name: json['Name'].toString(),
      status: json['Status'],
      journalDate: json['JournalDate'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      financeYear: json['FinanceYear'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      amount: json['Amount'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      userType: json['UserType'].toString(),
      userName: json['UserName'].toString(),
    );
  }
}
