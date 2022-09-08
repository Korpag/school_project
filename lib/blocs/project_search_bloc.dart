import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/project.dart';
import 'package:school_project/services/project.dart';

part 'project_search_event.dart';

part 'project_search_state.dart';

class ProjectsSearchBloc
    extends Bloc<ProjectsSearchEvent, ProjectsSearchState> {
  final ProjectService _projectService;
  String? searchText;

  ProjectsSearchBloc(this._projectService, {this.searchText})
      : super(ProjectsSearchLoadingState()) {
    on<ProjectsSearchLoadApiEvent>((event, emit) async {
      emit(ProjectsSearchLoadingState());
      final dataProject =
          await _projectService.getSearchProject(searchText: searchText);
      emit(ProjectsSearchLoadedState(dataProject.projects ?? []));
    });
  }
}
