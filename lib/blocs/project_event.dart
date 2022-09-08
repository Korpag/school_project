part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

class ProjectLoadApiEvent extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

