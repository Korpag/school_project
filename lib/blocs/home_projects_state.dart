part of 'home_projects_bloc.dart';

@immutable
abstract class HomeProjectsState extends Equatable {}

class HomeProjectsLoadingState extends HomeProjectsState {
  @override
  List<Object> get props => [];
}

class HomeProjectsLoadedState extends HomeProjectsState {
  final List<ProjectElement> projects;

  HomeProjectsLoadedState(this.projects);

  @override
  List<Object> get props => [projects];
}
