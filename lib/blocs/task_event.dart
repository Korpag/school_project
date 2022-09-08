part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskLoadApiEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}
