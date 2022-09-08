import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/news.dart';
import 'package:school_project/services/news.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;
  int? id;

  NewsBloc(this._newsService, {this.id}) : super(NewsLoadingState()) {
    on<NewsLoadApiEvent>((event, emit) async {
      emit(NewsLoadingState());
      final dataNews = await _newsService.getFullNews(id: id);
      emit(NewsLoadedState(dataNews.news ?? NewsElement()));
    });
  }
}
