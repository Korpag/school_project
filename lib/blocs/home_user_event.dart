part of 'home_user_bloc.dart';

@immutable
abstract class HomeUserEvent extends Equatable {
  const HomeUserEvent();
}

class HomeUserLoadApiEvent extends HomeUserEvent {
  @override
  List<Object?> get props => [];
}
