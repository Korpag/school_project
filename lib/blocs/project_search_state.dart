part of 'project_search_bloc.dart';

@immutable
abstract class ProjectsSearchState extends Equatable {}

class ProjectsSearchLoadingState extends ProjectsSearchState {
  @override
  List<Object> get props => [];
}

class ProjectsSearchLoadedState extends ProjectsSearchState {
  final List<ProjectElement> projects;

  ProjectsSearchLoadedState(this.projects);

  @override
  List<Object> get props => [projects];
}
