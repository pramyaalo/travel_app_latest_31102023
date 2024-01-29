class ViewJournalEntryModel {
  String journalEntryId;
  String journalEntryTypeId;
  String serialNo;
  String referenceNo;
  String company;
  String financeYear;
  String journalDate;
  String accountTypeId;
  String subAccountTypeId;
  String superAccountTypeId;
  String type;
  String name;
  String amount;
  String debit;
  String credit;
  int status;
  String notes;
  String createdDate;
  String journalEntry;
  String journalDate1;
  String accountTypeName;
  String financeYearId;
  String subAccountTypeName;
  String superAccountTypeName;
  String userTypeId;
  String userId;
  String userType;
  String userName;
  String currencyCode;

  ViewJournalEntryModel({
    required this.journalEntryId,
    required this.journalEntryTypeId,
    required this.serialNo,
    required this.referenceNo,
    required this.company,
    required this.financeYear,
    required this.journalDate,
    required this.accountTypeId,
    required this.subAccountTypeId,
    required this.superAccountTypeId,
    required this.type,
    required this.name,
    required this.amount,
    required this.debit,
    required this.credit,
    required this.status,
    required this.notes,
    required this.createdDate,
    required this.journalEntry,
    required this.journalDate1,
    required this.accountTypeName,
    required this.financeYearId,
    required this.subAccountTypeName,
    required this.superAccountTypeName,
    required this.userTypeId,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.currencyCode,
  });

  factory ViewJournalEntryModel.fromJson(Map<String, dynamic> json) {
    return ViewJournalEntryModel(
      journalEntryId: json['JournalEntryId'].toString(),
      journalEntryTypeId: json['JournalEntryTypeId'].toString(),
      serialNo: json['SerialNo'].toString(),
      referenceNo: json['ReferenceNo'].toString(),
      company: json['Company'].toString(),
      financeYear: json['FinanceYear'].toString(),
      journalDate: json['JournalDate'].toString(),
      accountTypeId: json['AccountTypeId'].toString(),
      subAccountTypeId: json['SubAccountTypeId'].toString(),
      superAccountTypeId: json['SuperAccountTypeId'].toString(),
      type: json['Type'].toString(),
      name: json['Name'].toString(),
      amount: json['Amount'].toString(),
      debit: json['Debit'].toString(),
      credit: json['Credit'].toString(),
      status: json['Status'],
      notes: json['Notes'].toString(),
      createdDate: json['CreatedDate'].toString(),
      journalEntry: json['JournalEntry'].toString(),
      journalDate1: json['JournalDate1'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      financeYearId: json['FinanceYearId'].toString(),
      subAccountTypeName: json['SubAccountTypeName'].toString(),
      superAccountTypeName: json['SuperAccountTypeName'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      userType: json['UserType'].toString(),
      userName: json['UserName'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
    );
  }
}
