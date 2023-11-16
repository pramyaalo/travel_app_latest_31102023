class LoginModel {
  final String UserType;
  final String UserTypeId;
  final String UserID;
  final String Username;
  final String Name;
  final String Password;
  final String TransactionPassword;
  final String ContactEmail;
  final String ApproveStatus;
  final String Mobile;
  final String Timein;
  final String Timeout;
  final String IsActive;
  final String Two;
  final String Photo;
  final String Paypal;
  final String Payza;
  final String Datecreated;
  final String Currency;

//<editor-fold desc="Data Methods">

  LoginModel({
    required this.UserType,
    required this.UserTypeId,
    required this.UserID,
    required this.Username,
    required this.Name,
    required this.Password,
    required this.TransactionPassword,
    required this.ContactEmail,
    required this.ApproveStatus,
    required this.Mobile,
    required this.Timein,
    required this.Timeout,
    required this.IsActive,
    required this.Two,
    required this.Photo,
    required this.Paypal,
    required this.Payza,
    required this.Datecreated,
    required this.Currency,
  });

  factory LoginModel.fromJson(Map<String, dynamic> map) {
    return LoginModel(
      UserType: map['UserType'].toString(),
      UserTypeId: map['UserTypeId'].toString(),
      UserID: map['UserID'].toString(),
      Username: map['Username'].toString(),
      Name: map['Name'].toString(),
      Password: map['Password'].toString(),
      TransactionPassword: map['TransactionPassword'].toString(),
      ContactEmail: map['ContactEmail'].toString(),
      ApproveStatus: map['ApproveStatus'].toString(),
      Mobile: map['Mobile'].toString(),
      Timein: map['Timein'].toString(),
      Timeout: map['Timeout'].toString(),
      IsActive: map['IsActive'].toString().toString(),
      Two: map['Two'].toString().toString(),
      Photo: map['Photo'].toString(),
      Paypal: map['Paypal'].toString().toString(),
      Payza: map['Payza'].toString().toString(),
      Datecreated: map['Datecreated'].toString(),
      Currency: map['Currency'].toString(),
    );
  }
}
