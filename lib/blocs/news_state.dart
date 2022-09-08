part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  final NewsElement news;

  NewsLoadedState(this.news);

  @override
  List<Object> get props => [news];
}
