import '../model/news_model.dart';

class AllNewsRepository {
  final Map<String, NewsModel> _news = {};
  Map<String, NewsModel> get getNews => _news;

  addAll(Map<String, NewsModel> other) {
    _news.addAll(other);
  }

  removeAll() {
    _news.clear();
  }
}
