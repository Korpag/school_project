import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/news.dart';
import 'package:school_project/services/news.dart';

part 'home_news_event.dart';

part 'home_news_state.dart';

class HomeNewsBloc extends Bloc<HomeNewsEvent, HomeNewsState> {
  final NewsService _newsService;

  HomeNewsBloc(this._newsService) : super(HomeNewsLoadingState()) {
    on<HomeNewsLoadApiEvent>((event, emit) async {
      emit(HomeNewsLoadingState());
      final dataNews = await _newsService.getNews();
      emit(HomeNewsLoadedState(dataNews.news ?? []));
    });
  }
}
