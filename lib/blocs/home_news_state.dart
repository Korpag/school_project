part of 'home_news_bloc.dart';

@immutable
abstract class HomeNewsState extends Equatable {}

class HomeNewsLoadingState extends HomeNewsState {
  @override
  List<Object> get props => [];
}

class HomeNewsLoadedState extends HomeNewsState {
  final List<NewsElement> news;

  HomeNewsLoadedState(this.news);

  @override
  List<Object> get props => [news];
}
