import 'package:news_tutorial/models/category_news_model.dart';
import 'package:news_tutorial/models/news_channel_headlines_model.dart';
import 'package:news_tutorial/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

// news channel
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);

    return response;
  }

// news category
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);

    return response;
  }
}
