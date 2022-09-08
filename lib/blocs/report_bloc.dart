import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/report.dart';
import 'package:school_project/services/project.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportService _reportService;
  final int? id;

  ReportBloc(this._reportService, {this.id}) : super(ReportLoadingState()) {
    on<ReportLoadApiEvent>((event, emit) async {
      emit(ReportLoadingState());
      final dataReport = await _reportService.getReport(id: id);
      emit(ReportLoadedState(dataReport.report ?? ReportClass()));
    });
  }
}
