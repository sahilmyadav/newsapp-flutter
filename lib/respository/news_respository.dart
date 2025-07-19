//
//
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_feed_app/models/categories_new_model.dart';
import 'package:new_feed_app/models/news_channel_headlines_model.dart';
//

class NewsRespository{
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{



    if(category == 'Sport'){
      category = 'sport';
    }

    String url = "https://newsapi.org/v2/top-headlines?country=in&category=${category}&apiKey=423f332ac1094ec19c504d3afdc220d0";

    final response = await http.get(Uri.parse(url));



    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);


    }
    else{
      throw Exception('Error! 404');
    }

  }

  Future<NewsChannelsHeadlinesmodel> fetchNewsChannelHeadlinesApi(String channelName)async{

    String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=423f332ac1094ec19c504d3afdc220d0";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesmodel.fromJson(body);


    }
    else{
      throw Exception('Error! 404');
    }

  }
}

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:new_feed_app/models/categories_new_model.dart';
// import 'package:new_feed_app/models/news_channel_headlines_model.dart';
//
// class NewsService {
//   final String _baseUrl = 'https://newsapi.org/v2';
//   final String _apiKey = 'YOUR_API_KEY_HERE';
//
//   Future<NewsChannelsHeadlinesmodel> fetchNewsChannelHeadlinesApi(String country) async {
//     final url = Uri.parse('$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       return NewsChannelsHeadlinesmodel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load news channel headlines');
//     }
//   }
//
//   Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
//     final url = Uri.parse('$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       return CategoriesNewsModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load news categories');
//     }
//   }
//
//   Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
//
//
//
//     if(category == 'Sport'){
//       category = 'sport';
//     }
//
//     String url = "https://newsapi.org/v2/top-headlines?country=in&category=${category}&apiKey=960c23f33846417bab40b8def53c65bf";
//
//     final response = await http.get(Uri.parse(url));
//
//
//
//     if(response.statusCode == 200){
//       final body = jsonDecode(response.body);
//       return CategoriesNewsModel.fromJson(body);
//
//
//     }
//     else{
//       throw Exception('Error! 404');
//     }
//
//   }
// }