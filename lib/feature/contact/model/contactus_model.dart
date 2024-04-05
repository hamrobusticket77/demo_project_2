class ContactUsModel {
  String ? firstName;
  String ? middleName;
  String ? lastName;
  String ? email;
  String ? phoneNumber;
  String ? address;
  String ? subject;
  String ? message;

  ContactUsModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.subject,
    this.message,
  });
    Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["firstName"] = firstName;
    map["middleName"] = middleName;
    map["lastName"] = lastName;
    map["email"] = email;
    map["phoneNumber"] = phoneNumber;
    map["address"] = address;
    map["subject"] = subject;
    map["message"] = message;
    return map;
  }
}