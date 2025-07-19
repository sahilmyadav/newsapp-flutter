



import 'package:bloc/bloc.dart';
import 'package:new_feed_app/respository/news_respository.dart';
import 'news_event.dart';
import 'news_state.dart';




class NewsBloc extends Bloc<NewsEvent , NewsState> {
  NewsService postRepository = NewsService();

  NewsBloc() :super(NewsState()) {
    on<FetchNewsChannelHeadlines>(fetchChannelNews);
    on<NewsCategories>(fetchCategoriesNewsApi);
  }

  Future<void> fetchChannelNews(FetchNewsChannelHeadlines event,
      Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    await postRepository.fetchNewsChannelHeadlinesApi(event.channelId).then((
        value) {
      emit(
          state.copyWith(
              status: Status.success,
              newsList: value,
              message: 'success'
          )
      );
    }).onError((error, stackTrace) {
      emit(
          state.copyWith(
              categoriesStatus: Status.failure,
              categoriesMessage: error.toString()
          )
      );
    });
  }

  Future<void> fetchCategoriesNewsApi(NewsCategories event,
      Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    await postRepository.fetchCategoriesNewsApi(event.category).then((value) {
      emit(
          state.copyWith(
              categoriesStatus: Status.success,
              categoriesNewsModel: value,
              categoriesMessage: 'success'
          )
      );
    }).onError((error, stackTrace) {
      emit(
          state.copyWith(
              categoriesStatus: Status.failure,
              categoriesMessage: error.toString()
          )
      );
      emit(
          state.copyWith(
              status: Status.failure,
              message: error.toString()
          )
      );
    });
  }
}
