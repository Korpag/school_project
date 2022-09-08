import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/services/project.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService _taskService;
  final int? id;

  TaskBloc(this._taskService, {this.id}) : super(TaskLoadingState()) {
    on<TaskLoadApiEvent>((event, emit) async {
      emit(TaskLoadingState());
      final dataTask = await _taskService.getTask(id: id);
      emit(TaskLoadedState(dataTask.task ?? TaskClass()));
    });
  }
}
