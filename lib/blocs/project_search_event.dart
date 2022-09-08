part of 'project_search_bloc.dart';

@immutable
abstract class ProjectsSearchEvent extends Equatable {
  const ProjectsSearchEvent();
}

class ProjectsSearchLoadApiEvent extends ProjectsSearchEvent {
  @override
  List<Object?> get props => [];
}
