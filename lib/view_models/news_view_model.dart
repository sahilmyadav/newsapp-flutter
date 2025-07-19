


import 'package:new_feed_app/models/categories_new_model.dart';
import 'package:new_feed_app/models/news_channel_headlines_model.dart';
import 'package:new_feed_app/respository/news_respository.dart';

class NewsViewModel {
  final _rep = NewsRespository();

  Future<NewsChannelsHeadlinesmodel> fetchNewsChannelHeadlinesApi(String channelName)async{

    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response;

  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{

    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;

  }

}
