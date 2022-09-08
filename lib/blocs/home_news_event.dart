part of 'home_news_bloc.dart';

@immutable
abstract class HomeNewsEvent extends Equatable {
  const HomeNewsEvent();
}

class HomeNewsLoadApiEvent extends HomeNewsEvent {
  @override
  List<Object?> get props => [];
}
