class Regex {
  static final RegExp removeAllSpecialChar = RegExp(r'[^\w\s]');
  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp passwordRegex =
      RegExp(r"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!]).*$");
  static final RegExp phoneNumberRegex = RegExp(r'([9][678][0-6][0-9]{7})');

  static final RegExp numberOnlyRegex = RegExp(r'^[0-9]+$');

  static final RegExp nepaliTextOnlyRegex = RegExp(r'[a-zA-Z]+');
}
