part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {}

class TaskLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoadedState extends TaskState {
  final TaskClass task;

  TaskLoadedState(this.task);

  @override
  List<Object> get props => [task];
}
