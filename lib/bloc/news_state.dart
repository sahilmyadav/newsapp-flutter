
import 'package:equatable/equatable.dart';
import 'package:new_feed_app/models/categories_new_model.dart';
import 'package:new_feed_app/models/news_channel_headlines_model.dart';




enum Status { initial, success, failure }

class NewsState extends Equatable {


  NewsState({
    this.status = Status.initial,
    this.categoriesStatus = Status.initial,
    this.categoriesMessage = '' ,
    this.message = '',
    NewsChannelsHeadlinesmodel? newsList  ,
    CategoriesNewsModel? categoriesNewsModel ,
  })  :  newsList = newsList ?? NewsChannelsHeadlinesmodel() , newsCategoriesList = categoriesNewsModel ?? CategoriesNewsModel();

  final Status status;
  final NewsChannelsHeadlinesmodel? newsList;
  final String message;
  final Status categoriesStatus  ;
  final String categoriesMessage  ;
  final CategoriesNewsModel? newsCategoriesList ;

  NewsState copyWith({
    Status? status,
    NewsChannelsHeadlinesmodel? newsList,
    String? message,
    CategoriesNewsModel? categoriesNewsModel,
    String? categoriesMessage,
    Status? categoriesStatus

  }) {
    return NewsState(
      status: status ?? this.status,
      newsList: newsList ??  this.newsList,
      message: message ?? this.message,
      categoriesMessage: message ?? this.categoriesMessage,
      categoriesNewsModel: categoriesNewsModel ?? this.newsCategoriesList,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $message,}''';
  }

  @override
  List<Object?> get props => [status, newsList, message,identityHashCode(this) ];
}
