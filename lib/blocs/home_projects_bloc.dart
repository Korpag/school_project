import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/project.dart';
import 'package:school_project/services/project.dart';

part 'home_projects_event.dart';

part 'home_projects_state.dart';

class HomeProjectsBloc extends Bloc<HomeProjectsEvent, HomeProjectsState> {
  final ProjectService _projectService;

  HomeProjectsBloc(this._projectService) : super(HomeProjectsLoadingState()) {
    on<HomeProjectsLoadApiEvent>((event, emit) async {
      emit(HomeProjectsLoadingState());
      final dataProject = await _projectService.getProject();
      emit(HomeProjectsLoadedState(dataProject.projects ?? []));
    });
  }
}
