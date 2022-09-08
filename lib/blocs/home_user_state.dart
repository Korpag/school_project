part of 'home_user_bloc.dart';

@immutable
abstract class HomeUserState extends Equatable {}

class HomeUserLoadingState extends HomeUserState {
  @override
  List<Object> get props => [];
}

class HomeUserLoadedState extends HomeUserState {
  final UserClass user;

  HomeUserLoadedState(this.user);

  @override
  List<Object> get props => [user];
}
