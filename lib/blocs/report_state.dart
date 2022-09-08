part of 'report_bloc.dart';

@immutable
abstract class ReportState extends Equatable {}

class ReportLoadingState extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportLoadedState extends ReportState {
  final ReportClass report;

  ReportLoadedState(this.report);

  @override
  List<Object> get props => [report];
}
