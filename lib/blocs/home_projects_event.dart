part of 'home_projects_bloc.dart';

@immutable
abstract class HomeProjectsEvent extends Equatable {
  const HomeProjectsEvent();
}

class HomeProjectsLoadApiEvent extends HomeProjectsEvent {
  @override
  List<Object?> get props => [];
}
