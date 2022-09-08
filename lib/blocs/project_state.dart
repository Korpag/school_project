part of 'project_bloc.dart';

@immutable
abstract class ProjectState extends Equatable {}

class ProjectLoadingState extends ProjectState {
  @override
  List<Object> get props => [];
}

class ProjectLoadedState extends ProjectState {
  final ProjectElement project;

  ProjectLoadedState(this.project);

  @override
  List<Object> get props => [project];
}
