class FeedbackParams {
  String? name;
  String? phoneNumber;
  String? email;
  String? title;
  String? description;

  FeedbackParams(
      {this.name, this.phoneNumber, this.email, this.title, this.description});
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["phoneNumber"] = phoneNumber;
    map["email"] = email;
    map["title"] = title;
    map["description"] = description;

    return map;
  }
}
