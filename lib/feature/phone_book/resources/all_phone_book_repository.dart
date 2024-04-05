import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';

class AllPhoneBookRepository {
  final Map<String, PhoneBookModel> _getPhoneBook = {};
  Map<String, PhoneBookModel> get getPhoneBookList => _getPhoneBook;

  addAll(Map<String, PhoneBookModel> other) {
    _getPhoneBook.addAll(other);
  }

  removeAll() {
    _getPhoneBook.clear();
  }
}
