import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/project.dart';
import 'package:school_project/services/project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectService _projectService;
  final int? id;

  ProjectBloc(this._projectService, {this.id}) : super(ProjectLoadingState()) {
    on<ProjectLoadApiEvent>((event, emit) async {
      emit(ProjectLoadingState());
      final dataProject = await _projectService.getFullProject(id: id);
      emit(ProjectLoadedState(dataProject.project ?? ProjectElement()));
    });
  }
}
